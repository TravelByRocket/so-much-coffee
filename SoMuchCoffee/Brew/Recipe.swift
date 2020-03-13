//
//  Recipe.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/12/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

//struct Recipe : Identifiable, Hashable { // seems to break with Hashable added even when I leave the functions that make it fulfill Hashable
struct Recipe : Identifiable, Codable {
    var id = UUID()
    var name: String = ""
	var steps: [RecipeStep] = []
	var isUpright: Bool?
	var isPaper: Bool?
	
	var totalTimeSec: Int {
		var totalTime: Int = 0
		for step in steps {
			let tempDesc = step.descriptor
//			let stepTime = 0
			switch tempDesc {
			case .wait(let secs):
				totalTime += secs
			case .addWater(let secs, _):
				totalTime += secs
			case .plunge(let secs):
				totalTime += secs
			case .stir(let secs):
				totalTime += secs
			default:
				totalTime += 0
			}
		}
		return totalTime
	}
	
//	func hash(into hasher: inout Hasher) {
//		hasher.combine(id)
//	}
//
	static func ==(lhs: Recipe, rhs: Recipe) -> Bool {
		return lhs.id == rhs.id
	}
}

#if DEBUG
var testRecipes = [
    Recipe(name: "Unbelievable Brew"),
    Recipe(name: "Lucky Beans"),
    Recipe(name: "Brew of Faith"),
    Recipe(name: "Caffeine Healer"),
    Recipe(name: "Can't Stop Brewing")
]

#endif
