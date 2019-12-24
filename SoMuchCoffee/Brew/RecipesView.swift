//
//  RecipesView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/9/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RecipesView: View {
    var recipes: [Recipe] = testRecipes
    @EnvironmentObject var settings: UserSettings
    var body: some View {
		NavigationView{
			VStack {
				HStack{
					Spacer()
					GoHome()
				}
				.padding()
				
				List {
					Text("AeroPress")
					ForEach (recipes) {recipe in
						NavigationLink(destination: RecipeConductor(recipe: recipe)){
							Text(recipe.name)
						}
					}
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
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
