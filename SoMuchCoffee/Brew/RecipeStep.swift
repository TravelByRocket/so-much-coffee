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
	
	init(isCombinable: Bool, forceAsLastGroupedStep: Bool = false) {
		self.isCombinable = isCombinable
		self.forceAsLastGroupedStep = forceAsLastGroupedStep
	}
	
	func asString() -> String {
		return "This belongs to RecipeStep"
	}
	
	func asViewForList() -> AnyView {
		return AnyView(Text("View from RecipeStep"))
	}

	// NOTE could change RecipeStep to protocol or just make a protocol that applies to all the individual step types to make sure that I cover all the methods that I expect to have
	
}
