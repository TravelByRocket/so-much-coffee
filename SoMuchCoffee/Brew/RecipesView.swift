//
//  RecipesView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/9/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RecipesView: View {
    @ObservedObject var recipes = Recipes()
	@State var showSheet = false
	@State var showNavViewTemp = false
	
	var body: some View {
		NavigationView{
			VStack {
				Text("Long hold a recipe to run or edit").italic()
				List {
					Section (header:
							HStack {
							Text("AeroPress")
							Spacer()
							Button(action: {self.makeFullRecipe()}){
								HStack {
									Text("Demo Recipe").foregroundColor(Color.green).padding(.trailing,-3)
									Image(systemName: "plus.circle").foregroundColor(Color.green)
								}
							}
							Spacer()
							NavigationLink(destination: RecipeBuilder(recipes: recipes)){
								HStack {
									Text("New").foregroundColor(Color.purple).padding(.trailing,-3)
									Image(systemName: "plus.circle").foregroundColor(Color.purple)
								}
							}
						}

					) {
						ForEach (recipes.items) {recipe in
							HStack{
								Text(recipe.name)
								Spacer()
							}
							.contextMenu(menuItems: {
								// TODO move "run" access to a click on each row; ran into issues having one NavigationLink for list item and another for ContextMenu or getting both on list item but I was able to get both in context menu without issue
								NavigationLink(destination: RecipeConductor(recipe: recipe)) {Text("Run")}
								NavigationLink(destination: RecipeBuilder(recipe: recipe, recipes: self.recipes)) {Text("Edit")}
							})
						}
						.onDelete(perform: deleteItem)
						.onMove(perform: moveItem)
						.padding()
						.overlay(RoundedRectangle(cornerRadius: 10)
					.stroke(Color.black, lineWidth: 1))
					}
					Section (header: Text("Pourover")) {Text("Under development")}
					Section (header: Text("French Press")) {Text("Under development")}
					Section (header: Text("Espresso")) {Text("Under development")}
				}
				.navigationBarTitle("Saved Recipes")
				
//				Spacer()
//				Button(action: {self.makeFullRecipe()}){
//					Text("Auto-fill a test recipe\n")
//				}
//				NavigationLink(destination: RecipeBuilder(recipes: recipes)){
//					Text("Add New Recipe\n")
//				}
			}
			.navigationBarTitle("Saved Recipes")
			.navigationBarItems(trailing: GoHome())
		}
    }
	
	private func moveItem(from source: IndexSet, to destination: Int) {
		self.recipes.items.move(fromOffsets: source, toOffset: destination)
    }
	
	private func deleteItem(at offsets: IndexSet) {
		self.recipes.items.remove(atOffsets: offsets)
    }
	
	func makeFullRecipe() {
		var newRecipe = Recipe(id: UUID(), name: "My First Inverted Recipe", steps: [], isUpright: true, isPaper: true)
		newRecipe.steps.append(RecipeStep(kindOfStep: .heatWater(tempC: 88), isCombinable: true))
		newRecipe.steps.append(RecipeStep(kindOfStep: .rinseFilter, isCombinable: true))
		newRecipe.steps.append(RecipeStep(kindOfStep: .grind(grams: 18), isCombinable: true))
		newRecipe.steps.append(RecipeStep(kindOfStep: .addWater(seconds: 10, grams: 50), isCombinable: false))
		newRecipe.steps.append(RecipeStep(kindOfStep: .wait(seconds: 30),isCombinable: true, forceAsLastGroupedStep: true))
		newRecipe.steps.append(RecipeStep(kindOfStep: .addWater(seconds: 35, grams: 100), isCombinable: false))
		newRecipe.steps.append(RecipeStep(kindOfStep: .stir(seconds: 30), isCombinable: false))
		newRecipe.steps.append(RecipeStep(kindOfStep: .addWater(seconds: 15, grams: 80), isCombinable: false))
		newRecipe.steps.append(RecipeStep(kindOfStep: .stir(seconds: 30), isCombinable: false))
		newRecipe.steps.append(RecipeStep(kindOfStep: .wait(seconds: 15),isCombinable: true, forceAsLastGroupedStep: true))
		newRecipe.steps.append(RecipeStep(kindOfStep: .installFilter, isCombinable: true))
		newRecipe.steps.append(RecipeStep(kindOfStep: .installPlunger, isCombinable: true))
		newRecipe.steps.append(RecipeStep(kindOfStep: .plunge(seconds: 20), isCombinable: false))
		self.recipes.items.append(newRecipe)
	}
}

struct RecipesView_Previews: PreviewProvider {
    @State static var fakeRecipes = testRecipes
	static var previews: some View {
		RecipesView()
    }
}
