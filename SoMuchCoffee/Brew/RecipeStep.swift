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
	
	func asView() -> AnyView {
		return AnyView(Text("View from RecipeStep"))
	}
	
	struct descriptionView: View {
		var body: some View {
			Text("it's a view!")
		}
	}
	
}

class FilterStep: RecipeStep {
	init() {
		super.init(isCombinable: true)
	}
	
	override func asString() -> String {
		return "This belongs to FilterStep"
	}
	
	override func asView() -> AnyView {
		return AnyView(
			Text("Underlined").underline()+Text(" and not underlined"))
	}

}
