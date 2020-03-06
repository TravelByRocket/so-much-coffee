//
//  RecipeBuilder.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/9/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RecipeBuilder: View {
	@State var recipe: Recipe = Recipe()
	
    @State private var isSelectedUpright: Bool = false
    @State private var isSelectedInverted: Bool = false
    @State private var isSelectedPaper: Bool = false
    @State private var isSelectedMetal: Bool = false
    @State private var canAddSteps: Bool = false
    @State private var showStepsPopover: Bool = false
    
//	NOTE Seems this might be good place to implement Modal sheet
	
    var body: some View {
        ZStack {
            VStack {
                // RECIPE NAME
                HStack {
					TextField("Recipe Name", text: $recipe.name)
					Button(action: {self.recipe.name = self.randomTitle()}) {
						Image(systemName: "shuffle").rotationEffect(.degrees(180))
						Text("Generate")
					}
                }
                .padding()
                
                // SELECT UPRIGHT OR INVERTED
                HStack (spacing: 0){
                    
                    // UPRIGHT SELECTION
					OptionBox(msg: "Upright\nMethod")
					.background(isSelectedUpright ? Color(red: 147/255, green: 255/255, blue: 175/255, opacity: 1.0) : appLightGray)
					.onTapGesture {
						self.isSelectedUpright = true
						self.isSelectedInverted = false
						self.checkInitialConditions()
					}
                    
                    // INVERTED SELECTION
                    OptionBox(msg: "Inverted\nMethod")
                    .background(isSelectedInverted ? Color(red: 176/255, green: 160/255, blue: 255/255, opacity: 1.0) : appLightGray)
                    .onTapGesture {
						self.isSelectedUpright = false
						self.isSelectedInverted = true
						self.checkInitialConditions()
                    }
                }
                .padding(.bottom)
				
                // FILTER SECTION
                HStack (spacing: 0){
                    // PAPER SELECTION
                    OptionBox(msg: "Paper\nFilter")
                    .background(isSelectedPaper ? Color(red: 255/255, green: 234/255, blue: 147/255, opacity: 1.0) : appLightGray)
                    .onTapGesture {
						self.isSelectedPaper = true
						self.isSelectedMetal = false
						self.checkInitialConditions()
                    }
                    
                    // METAL SELECTION
                    OptionBox(msg: "Metal\nFilter")
                    .background(isSelectedMetal ? Color(red: 255/255, green: 160/255, blue: 147/255, opacity: 1.0) : appLightGray)
                    .onTapGesture {
						self.isSelectedPaper = false
						self.isSelectedMetal = true
						self.checkInitialConditions()
                    }
                }
                .padding(.bottom)
				
				HStack{
					Spacer()
					EditButton()
				}.padding()
				
				Form{
					Section{
						ForEach(self.recipe.steps, id: \.id){step in
							self.getViewForList(recipeStep: step.descriptor)
						}
						.onDelete(perform: deleteItem)
						.onMove(perform: moveItem)
					}
				}
				
                if canAddSteps {
                    AddButton(isEnabled: true)
						.onTapGesture {self.showStepsPopover = true}
					Button(action: {testRecipes.append(self.recipe)}) {
						Text("Save Recipe")
					}
                } else {
					AddButton(isEnabled: false)
					Text("can't save")
                }
                
                Spacer()
            }
            if showStepsPopover {
				APStepsPopover(showPopover: $showStepsPopover, recipe: $recipe)
            }
		}
    }
	
	private func moveItem(from source: IndexSet, to destination: Int) {
		self.recipe.steps.move(fromOffsets: source, toOffset: destination)
    }
	
	private func deleteItem(at offsets: IndexSet) {
		self.recipe.steps.remove(atOffsets: offsets)
    }
	
	func getViewForList(recipeStep kind: KindOfStep) -> AnyView{
		switch kind {
		case .plunge(let secs):
			return AnyView(PlungeForList(duration: secs))
		case .installFilter:
			return AnyView(InstallFilterForList())
		case .installPlunger:
			return AnyView(InstallPlungerForList())
		case .heatWater(let tempC):
			return AnyView(HeatWaterForList(tempC: tempC))
		case .rinseFilter:
			return AnyView(RinseFilterForList())
		case .wait(let secs):
			return AnyView(WaitForList(duration: secs))
		case .stir(let secs):
			return AnyView(StirForList(duration: secs))
		case .addWater(let secs, let mass):
			return AnyView(AddWaterForList(duration: secs, mass: mass))
		case .grind(let mass):
			return AnyView(GrindForList(mass: mass))
		}
	}
    
    func checkInitialConditions(){
        canAddSteps = (isSelectedUpright || isSelectedInverted) && (isSelectedPaper || isSelectedMetal)
    }
	
	func randomTitle() -> String {
		var dateString: String {
			var dateFormatter: DateFormatter { //NOTE I don't know why the version in the documentation gives multiple errors but this closer version from HackingWithSwift works fine
				let formatter = DateFormatter()
				formatter.dateStyle = .medium
				formatter.timeStyle = .none
				return formatter
			}
			return dateFormatter.string(from: Date())
		}
		
		switch Int.random(in: 0...10) { // TODO make more completely random options
		case 0:
			return "Unbelievable Brew " + dateString
		case 1:
			return "Lucky Beans " + dateString
		case 2:
			return "Brew of Faith " + dateString
		case 3:
			return "Caffeine Healer " + dateString
		case 4:
			return "Can't Stop Brewing " + dateString
		case 5:
			return "Lucky Beans " + dateString
		case 6...10:
			var chaosName = ""
			let wordList = ["Unbelievable","Brew","Bean","Faith","Caffeine","Healer","Lucky","Energy","Morning","Anytime","Afternooon","Mindful","Sunset","Yogi","Mountain","Bliss","Vibe","Chakra","Peace","Tranquil","Amped","Lit","Celestial","Visionary"]
			let wordCount = 3
			for _ in 1...wordCount {
				chaosName += wordList[Int.random(in: 0..<wordList.count)]
				chaosName += " "
			}
			chaosName += dateString
			return chaosName
		default:
			return "Dunno " + dateString
		}
		
	}
}

struct RecipeBuilder_Previews: PreviewProvider {
    private static var fakeRecipe = Recipe()
	static var previews: some View {
		RecipeBuilder(recipe: fakeRecipe)
    }
}


struct OptionBox: View {
	var msg: String
	var body: some View {
		HStack {
			Spacer()
			Text(msg)
				.font(.title)
			Spacer()
		}
		.padding(.vertical, 40)
		.frame(minWidth: 0, maxWidth: .infinity)
		.border(Color.black, width: 1)
	}
}
