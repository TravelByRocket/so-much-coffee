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
	@State var showSheet = false
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
				Text("Try saving JSON here\n")
					.onTapGesture {
						let encoder = JSONEncoder()
						print(UserDefaults.standard.dictionaryRepresentation())
						
						
						if let data = try? encoder.encode(self.recipes) {
							print(String(data: data, encoding: .utf8)!)
							UserDefaults.standard.set(data, forKey: "recipes")
							print("Saved recipes to UserDefaults")
						} else {
							print("Failed to save recipes to UserDefaults")
						}
				}
				Text("Try a sheet here\n")
					.onTapGesture{self.showSheet = true}
					.sheet(isPresented: self.$showSheet, content: {RecipeBuilder()})
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
