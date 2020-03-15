//
//  RecipesView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/9/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RecipesView: View {
    @State var recipes: [Recipe] = []
	@State var showSheet = false
	@State var showNavViewTemp = false
	
	var body: some View {
		NavigationView{
			VStack {
				HStack{
					EditButton()
					Spacer()
					GoHome()
				}
				.padding()
				
				List {
					Text("AeroPress")
					ForEach (recipes) {recipe in
						HStack{
							Text(recipe.name)
							Spacer()
						}
						.contextMenu(menuItems: {
							// TODO move "run" access to a click on each row; ran into issues having one NavigationLink for list item and another for ContextMenu or getting both on list item but I was able to get both in context menu without issue
							NavigationLink(destination: RecipeConductor(recipe: recipe)) {Text("Run")}
							NavigationLink(destination: RecipeBuilder(recipe: recipe)) {Text("Edit")}
						})
					}
					.onDelete(perform: deleteItem)
					.onMove(perform: moveItem)
					.padding()
					.overlay(RoundedRectangle(cornerRadius: 10)
					.stroke(Color.black, lineWidth: 1))
					
				}
				.navigationBarTitle("Saved Recipes")
				
				Spacer()
				Button(action: {self.makeFullRecipe()}){
					Text("Auto-fill a test recipe\n")
				}
				NavigationLink(destination: RecipeBuilder()){
					Text("Add New Recipe\n")
				}
			}
		}
    }
	
	private func moveItem(from source: IndexSet, to destination: Int) {
		self.recipes.move(fromOffsets: source, toOffset: destination)
    }
	
	private func deleteItem(at offsets: IndexSet) {
		self.recipes.remove(atOffsets: offsets)
    }
	
	func makeFullRecipe() {
		var newRecipe = Recipe(id: UUID(), name: "Full Recipe (long hold to run/edit)", steps: [], isUpright: true, isPaper: true)
		newRecipe.steps.append(RecipeStep(kindOfStep: .heatWater(tempC: 80), isCombinable: true))
		newRecipe.steps.append(RecipeStep(kindOfStep: .rinseFilter, isCombinable: true))
		newRecipe.steps.append(RecipeStep(kindOfStep: .grind(grams: 15), isCombinable: true))
		newRecipe.steps.append(RecipeStep(kindOfStep: .addWater(seconds: 20, grams: 40), isCombinable: false))
		newRecipe.steps.append(RecipeStep(kindOfStep: .stir(seconds: 20), isCombinable: false))
		newRecipe.steps.append(RecipeStep(kindOfStep: .wait(seconds: 20),isCombinable: true, forceAsLastGroupedStep: true))
		newRecipe.steps.append(RecipeStep(kindOfStep: .installFilter, isCombinable: true))
		newRecipe.steps.append(RecipeStep(kindOfStep: .installPlunger, isCombinable: true))
		newRecipe.steps.append(RecipeStep(kindOfStep: .plunge(seconds: 20), isCombinable: false))
		self.recipes.append(newRecipe)
	}
}

struct RecipesView_Previews: PreviewProvider {
    @State static var fakeRecipes = testRecipes
	static var previews: some View {
		RecipesView(recipes: fakeRecipes)
    }
}
