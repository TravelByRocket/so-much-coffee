//
//  Plunge.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/2/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct PlungeForSettings: View {
	@Binding var recipe: Recipe // NOTE this should probably be environment object
	@State private var duration: Double = 20
    
	var body: some View {
        VStack {
            HStack {
                Image(systemName: "hare").padding()
				Slider(value: $duration, in: 5...45, step: 1.0)
                Image(systemName: "tortoise").padding()
            }
            Text("Plunge \(duration, specifier: "%.f") seconds")
			addToRecipe()
        }
    }
	
	func addToRecipe() -> AnyView{
		return AnyView(
			Button(action:
				{ self.recipe.steps.append(RecipeStep(kindOfStep: .plunge(seconds: Int(self.duration)),isCombinable: false))}) { Text("Add to Recipe") }
		)
	}
}

struct PlungeForList: View {
	var duration: Int
	var body: some View {
		Text("Plunge for ")+Text(String(duration)).underline()+Text(" seconds")
	}
}

struct PlungeForRecipe: View {
	var body: some View {
		HStack {
			Text("Install the filter").font(.title).padding()
			Spacer()
		}
		.overlay(RoundedRectangle(cornerRadius: 10)
		.stroke(Color.black)
		.foregroundColor(transparent))
		.padding()
	}
}

struct Plunge_Previews: PreviewProvider {
	@State private static var fakeRecipe = Recipe(name: "FakeRecipe")
    static var previews: some View {
        List{
			PlungeForSettings(recipe: $fakeRecipe)
			PlungeForList(duration: 20)
        }
    }
}
