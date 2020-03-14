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
    var name: String = "" // initially empty string but will have length when saved
	var steps: [RecipeStep] = [] // an array containing every step of completing the recipe
	var isUpright: Bool? // upright method vs inverted method, starts as nil but will have true/false when saved
	var isPaper: Bool? // paper filter vs metal filter, starts as nil but will have true/false when saved

	// Get the total time to run the recipe; Easier than having to get the last index of the transition times.
	var totalTimeSec: CGFloat { // CGFloat because (I think) Timer requires it
		var totalTime: CGFloat = 0 // collection (summing) variable, starting at 0
		for step in steps { // for each step in the array of all steps
			totalTime += CGFloat(timeForStep(step: step)) // add the time value for steps with times
		}
		return totalTime
	}

	// Time stamps for when to swtich to each step, including 0 and the total time; Adds up the time values for every step within a stage
	var switchTimesFromArranged: [CGFloat] { // The times are integers but (I think) Timer uses CGFloat
		var transitionTimes: [CGFloat] = [] // array to store the transitions times in, initally empty
		var cumulativeTime: CGFloat = 0 // temporary value to collect running time as I go through each step
		for stage in stepsArranged { // for each array the represents a stage
			for step in stage { // and for each step in that single stage
				cumulativeTime += CGFloat(timeForStep(step: step)) // add to the running total by pulling the time value from each ste
			}
			transitionTimes.append(cumulativeTime) // add a transiton time at the running total time, including a zero for the first (prep) steps of making the coffee
		}
		return transitionTimes
	}
	
	var stepsArranged: [[RecipeStep]] { // returns a 2D array containing every stage on the first dimension and every step within that stage on the second dimension
		var arranged = [[RecipeStep]]() // empty 2D array to start with, which will be returned when done
		var curStage = [RecipeStep]() // empty array to contain the steps within a stage
		for step in steps { // for every step in the entire recipe
			if step.isCombinable { // if the step can be combined with other
				curStage.append(step) // then add it to the stage, which collects all compatible steps
			} else { // otherwise (if it cannot be combined)
				if !curStage.isEmpty { // and the stage is not empty from reset at the end of previous step
					curStage.sort { !$0.forceAsLastGroupedStep && $1.forceAsLastGroupedStep } // then sort the stage so anything forced as last goes to the bottom
					arranged.append(curStage) // and then add it as a complete stage
				}
				arranged.append([step]) // and the current step gets its own dedicated stage because it cannot be combined
				curStage = [] // and the collecting stage should be cleared to start fresh on the next iteration
			}
		}
		if curStage.count > 0 { // also add the stage we were building once we have gotten to the end
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
	// send in any step and it will return the time value associated with it or 0
	let tempDesc = step.descriptor // assign the descripter enum
	switch tempDesc { // switch for the enums that have associed time values and return that number
		case .wait(let secs):
			return secs
		case .addWater(let secs, _):
			return secs
		case .plunge(let secs):
			return secs
		case .stir(let secs):
			return secs
		default: // unless there is no time value, then return 0
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
