//
//  recipeStepContainer.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/14/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RecipeStepContainer: ViewModifier {
	func body(content: Content) -> some View {
		content
			.overlay(
				RoundedRectangle(cornerRadius: 10)
					.stroke(Color.primary)
					.foregroundColor(transparent))
			.padding(.horizontal)
			.padding(.vertical,5)
	}
}

extension View {
	func recipeStepContainer() -> some View {
		self.modifier(RecipeStepContainer())
	}
}
