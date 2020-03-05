//
//  AddWater.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/4/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct AddWaterForRecipe: View {
    @Binding var timeElapsedSec: CGFloat
    var totalTimeSec : CGFloat
    var waterMassG : CGFloat
    
    var body: some View {
        VStack{
            HStack{
                // RESPONSIVE PROGRESS BAR VIEW
                TimerPillStep(timeElapsedSec: $timeElapsedSec, timeDurationSec: totalTimeSec)

                // WAIT STEP CONTENT
                HStack {
                    Spacer()
                    VStack {
                        Text("Pour \(waterMassG, specifier: "%.1f") g water over \(totalTimeSec, specifier: "%.f") seconds").font(.title).padding().fixedSize(horizontal: false, vertical: true)
                            
                        Stopwatch(timeElapsedSec: $timeElapsedSec, timeDurationSec: totalTimeSec).padding()
                        Text("\(waterMassG * (timeElapsedSec / totalTimeSec), specifier: "%.f")").font(Font.custom(monoregular, size: 50)).foregroundColor(Color.blue)
                        Text("grams poured of target \(waterMassG, specifier: "%.f") grams").font(Font.custom(monoregular, size: 15)).foregroundColor(Color.blue).padding(.bottom)
                    }
                    Spacer()
                }
            }
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black).foregroundColor(transparent))
        }.padding()
    }
}

struct AddWaterForSettings: View {
	@Binding var recipe: Recipe // NOTE this should probably be environment object
	@Binding var showPopover: Bool
	@Binding var showSettings: Bool
	
    @State private var duration: Double = 20
    @State private var mass: Double = 30
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "eyedropper").padding()
                Slider(value: $mass, in: 5...45, step: 1)
                Image(systemName: "eyedropper.full").padding()
            }
            Text("Pour \(mass, specifier: "%.f") grams of water")
            HStack {
                Image(systemName: "hare").padding()
                Slider(value: $duration, in: 5...45, step: 1)
                Image(systemName: "tortoise").padding()
            }
            Text("over \(duration, specifier: "%.f") seconds")
			addToRecipe()
        }
    }
	
	func addToRecipe() -> AnyView{
		return AnyView(
			Button(action:
				{ self.recipe.steps.append(RecipeStep(kindOfStep: .addWater(seconds: Int(self.duration), grams: Int(self.mass)),isCombinable: false))
					self.showPopover = false
					self.showSettings = false
			}) { Text("Add to Recipe") }
		)
	}
}

struct AddWaterForList: View {
	let duration: Int
	let mass: Int
	
    var body: some View {
		Text("Pour ")+Text("\(mass)").underline()+Text(" grams of water over ")+Text("\(duration)").underline()+Text(" seconds")
	}
}


struct AddWater_Previews: PreviewProvider {
	@State private static var fakeRecipe = Recipe(name: "FakeRecipe")
	@State private static var fakeShowPopover = true
	@State private static var fakeShowSettings = true
    @State private static var fakeElapsedTime: CGFloat = 5
    private static let fakeTotalTime: CGFloat = 9
    private static let fakeWaterMass: CGFloat = 30
    static var previews: some View {
		List{
			AddWaterForRecipe(timeElapsedSec: $fakeElapsedTime, totalTimeSec: fakeTotalTime, waterMassG: fakeWaterMass)
			AddWaterForSettings(recipe: $fakeRecipe, showPopover: $fakeShowPopover, showSettings: $fakeShowSettings)
			AddWaterForList(duration: 20, mass: 100)
		}
    }
}
