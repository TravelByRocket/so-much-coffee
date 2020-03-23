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
	@ObservedObject var recipes: Recipes
	
	@Environment(\.presentationMode) var presentationMode
	@Environment(\.editMode) var editMode
	
	@State private var canAddSteps: Bool = false
	@State private var showStepsPopover: Bool = false
	
	private var recipeReplacementIndex: Int? {
		var matchedRecipeIndex: Int?
		for searchIndex in 0 ..< self.recipes.items.count {
			if self.recipes.items[searchIndex].id == self.recipe.id {
				matchedRecipeIndex = searchIndex
			}
		}
		return matchedRecipeIndex
	}
	
	private var isNewRecipe: Bool {
		if recipeReplacementIndex == nil {
			return true
		} else {
			return false
		}
	}
	
	var body: some View {
		ZStack {
			VStack {
				// RECIPE NAME
				HStack {
					TextField("Recipe Name", text: $recipe.name)
						.textFieldStyle(RoundedBorderTextFieldStyle())
					Button(action: {self.recipe.name = self.randomTitle()}) {
						Image(systemName: "shuffle").rotationEffect(.degrees(180))
						Text("Randomize")
					}
				}
				.padding()
				
				// SELECT UPRIGHT OR INVERTED
				HStack (spacing: 0){
					
					// UPRIGHT SELECTION
					OptionBox(msg: "Upright\nMethod")
						.background(recipe.isUpright ?? false ? Color(red: 147/255, green: 255/255, blue: 175/255, opacity: 1.0) : appLightGray)
						.onTapGesture {
							self.recipe.isUpright = true
							self.checkInitialConditions()
					}
					
					// INVERTED SELECTION
					OptionBox(msg: "Inverted\nMethod")
						.background(!(recipe.isUpright ?? true) ? Color(red: 176/255, green: 160/255, blue: 255/255, opacity: 1.0) : appLightGray)
						.onTapGesture {
							self.recipe.isUpright = false
							self.checkInitialConditions()
					}
				}
				.padding(.bottom)
				
				// FILTER SECTION
				HStack (spacing: 0){
					// PAPER SELECTION
					OptionBox(msg: "Paper\nFilter")
						.background(recipe.isPaper ?? false ? Color(red: 255/255, green: 234/255, blue: 147/255, opacity: 1.0) : appLightGray)
						.onTapGesture {
							self.recipe.isPaper = true
							self.checkInitialConditions()
					}
					
					// METAL SELECTION
					OptionBox(msg: "Metal\nFilter")
						.background(!(recipe.isPaper ?? true) ? Color(red: 255/255, green: 160/255, blue: 147/255, opacity: 1.0) : appLightGray)
						.onTapGesture {
							self.recipe.isPaper = false
							self.checkInitialConditions()
					}
				}
				.padding(.bottom)
				
				HStack { //TODO put this HStack to a proper section heading for a (currently a List). Suspect the issue is that EditButton() modifies an environment that is a level deeper when it is embedded in a header. Need to find a way to bind the edit mode of the child view to the parent
					Text("Recipe Steps")
					Spacer()
					EditButton()
						.disabled(!canAddSteps)
				}
				.font(.footnote)
				.padding(.horizontal)
				.padding(.vertical,10)
					//				.foregroundColor(Color.black)
					.background(Color(UIColor.systemGray6))
				
				List {
					ForEach(self.recipe.steps, id: \.id){step in
						self.getViewForList(recipeStep: step.descriptor)
					}
					.onDelete(perform: deleteItem)
					.onMove(perform: moveItem)
					HStack {
						Spacer()
						Image(systemName: "plus").font(.title)
							.padding()
							.background(Color.orange)
							.mask(Circle())
							.overlay(
								Circle()
									.stroke(Color.primary, lineWidth: 1)
						)
							.onTapGesture {self.showStepsPopover = true}
							.disabled(!canAddSteps)
							.opacity(canAddSteps ? 1.0 : 0.3)
						Spacer()
					}
				Spacer()
				}
				
				Button(action: {
					if let matchIndex = self.recipeReplacementIndex {
						self.recipes.items[matchIndex] = self.recipe
					} else {
						self.recipes.items.append(self.recipe)
					}
					self.presentationMode.wrappedValue.dismiss()
				}) {
					HStack {
						Spacer()
						if recipe.canSave {
							Text(isNewRecipe ? "Save Recipe" : "Update Recipe").padding(.vertical)
						} else {
							Text("Incomplete Recipe").padding(.vertical)
						}
						Spacer()
					}
					.overlay(
						Capsule().stroke(recipe.canSave ? Color.green : Color.yellow, lineWidth: 5)
					)
				}
				.disabled(!recipe.canSave)
				.padding(.horizontal,40)
				
//				Spacer()
			}
			if showStepsPopover {
				APStepsPopover(showPopover: $showStepsPopover, recipe: $recipe)
			}
		}
		.navigationBarTitle("Aeropress Recipe")
		.navigationBarBackButtonHidden(true)
		.navigationBarItems(leading:
			Button(action: {
				self.presentationMode.wrappedValue.dismiss()
			}) {
				HStack {
					Image(systemName: "chevron.left")
					Text("Cancel")
				}
				.foregroundColor(Color.red)
		})
			.onAppear(perform: self.checkInitialConditions)
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
		canAddSteps = (recipe.isUpright != nil) && (recipe.isPaper != nil)
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
		
		switch Int.random(in: 0...20) { // TODO make more completely random options
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
		case 6...20:
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
	static var previews: some View {
		RecipeBuilder(recipes: Recipes())
	}
}


struct OptionBox: View {
	var msg: String
	var body: some View {
		HStack {
			Spacer()
			Text(msg)
				.font(.headline)
			Spacer()
		}
		.padding(.vertical, 20)
		.frame(minWidth: 0, maxWidth: .infinity)
		.border(Color.black, width: 1)
	}
}
