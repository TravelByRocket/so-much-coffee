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
        VStack {
            HStack{
                Spacer()
                GoHome()
            }
            .padding()
            Text("Saved Recipes")
                .foregroundColor(appOrange)
                .font(Font.custom(lato,size: 40))
            HStack {
                Text("AeroPress")
                    .font(.headline)
                Spacer()
            }
            .padding(.bottom, 0)
            .padding([.leading,.trailing,.top])
            
            ForEach (recipes) {recipe in
                RecipeRow(recipe: recipe)
                    .onTapGesture {
                        self.settings.curPage = "RECIPECONDUCTOR"
                }
            }
            
            Spacer()
            
            AddButton().onTapGesture {
                self.settings.curPage = "RECIPEBUILDER"
            }
        }
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
