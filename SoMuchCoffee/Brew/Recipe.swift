//
//  Recipe.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/12/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct Recipe : Identifiable {
    var id = UUID()
    var name: String
	var steps: [RecipeStep] = []
	
	
	mutating func addStep() -> Void {
		var tempStep = RecipeStep(isCombinable: true)
		steps.append(tempStep)
	}
}

#if DEBUG
let testRecipes = [
    Recipe(name: "Unbelievable Brew"),
    Recipe(name: "Lucky Beans"),
    Recipe(name: "Brew of Faith"),
    Recipe(name: "Caffeine Healer"),
    Recipe(name: "Can't Stop Brewing")
]

#endif
