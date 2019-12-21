//
//  RecipeRow.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/9/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RecipeRow: View {
    let recipe: Recipe
    var body: some View {
        HStack{
            Text(recipe.name)
                .font(.body)
            Spacer()
            Image("edit")
                .resizable()
                .frame(width: 40, height: 40)
                .colorInvert()
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
        .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(Color.black, lineWidth: 1))
        .padding(.horizontal)
        .padding(.vertical,0)
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            RecipeRow(recipe: testRecipes[0])
            RecipeRow(recipe: testRecipes[1])
            RecipeRow(recipe: testRecipes[2])
            RecipeRow(recipe: testRecipes[3])
            RecipeRow(recipe: testRecipes[4])
        }
    }
}
