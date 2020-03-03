//
//  RecipeStep.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 2/28/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

class RecipeStep: Identifiable {
	var id = UUID()
	var isCombinable: Bool
	var forceAsLastGroupedStep: Bool
	let descriptor: KindOfStep
	
	init(kindOfStep type: KindOfStep, isCombinable: Bool, forceAsLastGroupedStep: Bool = false) {
		self.descriptor = type
		self.isCombinable = isCombinable
		self.forceAsLastGroupedStep = forceAsLastGroupedStep
	}
}

enum KindOfStep {
	case addWater(seconds: Int, grams: Int)
	case grind(mass: Int) // future need for grinder name or type, setting name or value, maybe more
	case heatWater(tempC: Float?) // nil means "just boil"
	case insertPlunger
	case installFilter
	case plunge(seconds: Int)
	case rinseFilter
	case stir(seconds: Int)
	case wait(seconds: Int)
}
