//
//  RecipesView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/9/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RecipesView: View {
    @State var recipes: [Recipe] = testRecipes
//    @EnvironmentObject var settings: UserSettings
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
						NavigationLink(destination: RecipeBuilder(recipe: recipe)){
							Text(recipe.name)
						}
					}
					.onDelete(perform: deleteItem)
					.onMove(perform: moveItem)
					.padding()
					.overlay(RoundedRectangle(cornerRadius: 10)
						.stroke(Color.black, lineWidth: 1))
					
				}.navigationBarTitle("Saved Recipes")
				
				Spacer()
				
				NavigationLink(destination: RecipeBuilder()){
					Text("Add New Recipe")
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
}

struct RecipesView_Previews: PreviewProvider {
    @State static var fakeRecipes = testRecipes
	static var previews: some View {
		RecipesView(recipes: fakeRecipes)
    }
}
