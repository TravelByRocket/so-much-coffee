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
			totalTime += timeForStep(step: step)
		}
		return totalTime
	}
	
	var switchTimesSec: [Int] {
		var tempTimes: [Int] = []
		var tempRunTime: Int = 0
		for i in 0..<(steps.count - 1) { // logic within loop looks ahead one step
			tempRunTime += timeForStep(step: steps[i])
			if !steps[i+1].isCombinable{
				tempTimes.append(tempRunTime)
			}
		}
		return tempTimes
	}
	
	var switchTimesFromArranged: [Int] {
		var tempTimes: [Int] = []
		var tempRunTime: Int = 0
		for stage in stepsArranged {
			for step in stage {
				tempRunTime += timeForStep(step: step)
			}
			tempTimes.append(tempRunTime)
		}
		return tempTimes
	}
	
	var stepsArranged: [[RecipeStep]] {
		var arranged = [[RecipeStep]]()
		var curStage = [RecipeStep]()
		for step in steps {
			if step.isCombinable { // if the step can be combined with other
				curStage.append(step) // then add it to the stage, which collects all compatible steps
			} else { // otherwise (if it cannot be combined)
				if !curStage.isEmpty {
					arranged.append(curStage) // then the collecting stage is complete and is added to complete stages if it is not empty
				}
				arranged.append([step]) // and the current step gets its own dedicated stage because it cannot be combined
				curStage = [] // and the collecting stage should be cleared to collect on the next iteration
			}
		}
		if curStage.count > 0 {
			arranged.append(curStage)
		}
		return arranged
	}
	
//	func hash(into hasher: inout Hasher) {
//		hasher.combine(id)
//	}
//
	static func ==(lhs: Recipe, rhs: Recipe) -> Bool {
		return lhs.id == rhs.id
	}
	
}
	
func timeForStep(step: RecipeStep) -> Int{
	let tempDesc = step.descriptor
	switch tempDesc {
		case .wait(let secs):
			return secs
		case .addWater(let secs, _):
			return secs
		case .plunge(let secs):
			return secs
		case .stir(let secs):
			return secs
		default:
			return 0
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
