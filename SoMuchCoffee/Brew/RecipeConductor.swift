//
//  RecipeConductor.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/17/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RecipeConductor: View {
	var recipe: Recipe
	@State var timeElapsedSec: CGFloat = 0
	
	@State var timeElapsedStepSec: CGFloat = 0
	
	let timer = Timer.publish(every: Double(timerInterval), on: .main, in: .common).autoconnect()
	
	@State var curStage = 0
	@State var clockIsRunning = false
	
	var body: some View {
		
		VStack {
			Spacer()
			ScrollView (.vertical) {
				if curStage == 0 {
					VStack (alignment: .leading) {
						Text("- Prepare for Brewing")
						Text("- Recipe takes \(Int(recipe.totalTimeSec)) seconds")
						Text("- Recipe stages at \(intArrToString(recipe.switchTimes)) seconds")
					}
					Spacer()
					ForEach (recipe.stepsArranged[curStage]) {step in
						self.GetStepViewForRecipe(step: step)
					}
					Text("Tap to start brewing")
						.foregroundColor(Color.blue)
						.onTapGesture {self.clockIsRunning = true}
						.padding()
						.border(Color.blue, width: 1)
						.padding()
					// TODO a Next Step view e.g. Text("Next Step: Stir")
				} else if curStage > 0 && curStage < recipe.switchTimes.count {
	//				ScrollView (.vertical) {
						ForEach (recipe.stepsArranged[curStage]) {step in
							self.GetStepViewForRecipe(step: step)
						}
	//				}
					// TODO a Next Step view e.g. Text("Next Step: Stir")
				} else { // implies `curStage = recipe.switchTimesFromArranged.count`
					Text("Coffee Time!")
						.font(.largeTitle)
					Spacer()
				}
			}
			VStack {
				SkipForwardBack(curStage: $curStage, clockIsRunning: $clockIsRunning, timeElapsedSec: $timeElapsedSec, recipe: recipe)
				TimerPillTotal(timeElapsedSec: $timeElapsedSec, timeDurationSec: recipe.totalTimeSec)
					.navigationBarTitle(recipe.name)
					.onReceive(timer) { _ in // need to attach the timer to something, this made sense and it works
						if self.clockIsRunning {
							self.timeElapsedSec += timerInterval // progress elapsed time by timer interval every time it triggers, which is controlled by a global variable in ContentView
							self.curStage = self.recipe.switchTimes.firstIndex(where: { $0 > self.timeElapsedSec }) ?? self.recipe.stepsArranged.count // set the current stage index by finding the first index in the switch times array that is less than the current time; e.g. if the switch times are [0,20,40,60] then at time=25 the first index less than that is 1 and that is the stage index. TODO look into "stage" use and clarify `stage` being a set of of steps while `stageIndex` tells which step it is on; TODO see if there is a better nil coalescing value or a way to force unwrwap based on what I know in the logic of the program
							self.timeElapsedStepSec = self.timeElapsedSec - self.recipe.switchTimes[self.curStage-1] // the time that has passed in the current step is equal to the total elapsed time minus the previous switch time
							if self.timeElapsedSec >= self.recipe.totalTimeSec { // if the total elapsed time is >= the total recipe time (possibly from overshoot with CGFloat or system inaccuracy)
								self.clockIsRunning = false // then stop the clock
								self.timeElapsedSec = self.recipe.totalTimeSec // and set the elapsed time equal (exactly) to the total time that the recipe should run
							}
						}
					}
			}
		}
	}
	
	func GetStepViewForRecipe(step: RecipeStep) -> AnyView{
		let tempKind = step.descriptor
		switch tempKind {
		case .plunge(_):
			return AnyView(
				PlungeForRecipe(timeElapsedSec: $timeElapsedStepSec, totalTimeSec: CGFloat(recipe.switchTimes[curStage] - recipe.switchTimes[curStage - 1]))
			)
		case .installFilter:
			return AnyView(InstallFilterForRecipe())
		case .installPlunger:
			return AnyView(InstallPlungerForRecipe())
		case .heatWater(let tempC):
			return AnyView(HeatWaterForRecipe(tempC: tempC))
		case .rinseFilter:
			return AnyView(RinseFilterForRecipe())
		case .wait(_):
			return AnyView(
				WaitForRecipe(timeElapsedSec: $timeElapsedStepSec, totalTimeSec: CGFloat(recipe.switchTimes[curStage] - recipe.switchTimes[curStage - 1]))
			)
		case .stir(_):
			return AnyView(
				StirForRecipe(timeElapsedSec: $timeElapsedStepSec, totalTimeSec: CGFloat(recipe.switchTimes[curStage] - recipe.switchTimes[curStage - 1]))
			)
		case .addWater(_, let mass):
			return AnyView(
				AddWaterForRecipe(timeElapsedSec: $timeElapsedStepSec, totalTimeSec: CGFloat(recipe.switchTimes[curStage] - recipe.switchTimes[curStage - 1]), waterMassG: CGFloat(mass))
			)
		case .grind(let mass):
			return AnyView(GrindForRecipe(mass: mass))
		}
		
	}
}

struct RecipeConductor_Previews: PreviewProvider {
	static var recipes: [Recipe] = testRecipes
	static var previews: some View {
		NavigationView{
			RecipeConductor(recipe: recipes[0])
		}
	}
}

func intArrToString(_ arr: [CGFloat]) -> String {
	var tempString = "["
	for val in arr {
		tempString += String(Int(val)) + ","
	}
	if let extraCommaIndex = tempString.lastIndex(of: ",") {
		tempString.remove(at: extraCommaIndex)
	}
	
	tempString += "]"
	return tempString
}

struct SkipForwardBack: View {
	@Binding var curStage: Int
	@Binding var clockIsRunning: Bool
	@Binding var timeElapsedSec: CGFloat
	var recipe: Recipe
	
	var body: some View {
		HStack{
			Text("< Previous")
				.foregroundColor(curStage > 0 ? Color.primary : appLightGray) // if the current stage is not 0 then it is possible to go backward and so the button appears active; TODO change this to be actually active or (in)visible or something more concrete than this larger-than-needed chunk of logic
				.onTapGesture { // when the back button is tapped
					if self.curStage == 1 { // if the current stage index is 1
						self.timeElapsedSec = 0 // then set the timer (elapsed time) to 0
						self.clockIsRunning = false // and stop the clock
						self.curStage = 0 // and set the stage index to 0; TODO this might not be needed so delete if extraneous because this might be handled by stage index logic in the timer attachment block
					} else if self.curStage > 1 { // otherwise
						self.timeElapsedSec = self.recipe.switchTimes[self.curStage-2] // set the elapsed time equal to the beginning of the previous step; going back just 1 would only reset the current step, so go back 2 for the beginning of the previous step; the time switch associated with current stage is for when it completes
						self.clockIsRunning = true // this only changes anything after getting to the end of the recipe (it's already true) but no need to write more logic
					}
			}
			Spacer()
			Text("Next >")
				.foregroundColor(clockIsRunning ? Color.primary : appLightGray)
				.onTapGesture { // when the button is clicked
					if self.clockIsRunning { // if the clock is running
						self.timeElapsedSec = self.recipe.switchTimes[self.curStage] // then set the elapsed time equal to the time switch at current stage index because the associated time is actually when the current stage completes
					}
			}
		}.padding()
	}
}
