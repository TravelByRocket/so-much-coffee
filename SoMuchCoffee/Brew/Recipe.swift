//
//  Recipe.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/12/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

class Recipes: ObservableObject {
	@Published var items: [Recipe] {
		didSet {
			let encoder = JSONEncoder()
			if let encoded = try? encoder.encode(items) {
				UserDefaults.standard.set(encoded, forKey: "Recipes")
				print(encoded)
				print("JSON encoding success")
			} else {
				print("JSON encoding failed")
			}
		}
	}
	
	init() {
		if let items = UserDefaults.standard.data(forKey: "Recipes") {
			let decoder = JSONDecoder()
			if let decoded = try? decoder.decode([Recipe].self, from: items) {
				self.items = decoded
				print(decoded)
				print("JSON decoding success")
				return
			} else {
				print("JSON decoding failed")
			}
		}
		self.items = []
	}
	
}

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
	var switchTimes: [CGFloat] { // The times are integers but (I think) Timer uses CGFloat
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
	
	// considering computed properties or function to collectively allow or disallow save. This would be (1) start with a stage that has no time (the first index of switchtimes is 0), (2) not have an intermediate stage with no time (there are no adjacent switch times with the same time value), (3) Have a title, (4)
	
	var firstStagePrepValid: Bool {
		if switchTimes.count < 2 {return false}
		
		if switchTimes[0] == 0{ // not a valis recipe if not at least two steps
			return true
		} else {
			return false
		}
		
	}
	
	var allStagesTimeValid: Bool {
		if switchTimes.count < 2 {return false}
		
		var foundInvalid = false
		for i in 0 ..< (switchTimes.count - 1) {
			if switchTimes[i] == switchTimes[i + 1] {
				foundInvalid = true
			}
		}
		return !foundInvalid
	}
	
	var nameValid: Bool {
		if name != "" {
			return true
		} else {
			return false
		}
	}
	
	var methodSelected: Bool  {
		if isUpright != nil {
			return true
		} else {
			return false
		}
	}
	
	var filterSelected: Bool  {
		if isUpright != nil {
			return true
		} else {
			return false
		}
	}
	
	var canSave: Bool {
		if firstStagePrepValid && allStagesTimeValid && nameValid && methodSelected && filterSelected {
			return true
		} else {
			return false
		}
	}
	
	
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

var testRecipes = [
    Recipe(name: "Unbelievable Brew"),
    Recipe(name: "Lucky Beans"),
    Recipe(name: "Brew of Faith"),
    Recipe(name: "Caffeine Healer"),
    Recipe(name: "Can't Stop Brewing")
]
