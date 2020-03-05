//
//  Grind.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/4/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct GrindForList: View {
	let mass: Int
	var body: some View {
		Text("Grind ")+Text("\(mass)").underline()+Text(" grams of beans")
	}
}

struct GrindForRecipe: View {
	let mass: Int
	var body: some View {
		HStack {
			Text("Grind \(mass) grams of beans").font(.title).padding()
			Spacer()
		}
        .overlay(RoundedRectangle(cornerRadius: 10)
        .stroke(Color.primary)
        .foregroundColor(Color.clear))
        .padding()
	}
}

struct GrindForSettings: View {
	@Binding var recipe: Recipe // NOTE this should probably be environment object
	@Binding var showPopover: Bool
	@Binding var showSettings: Bool
	
	@State var mass: Double = 20
	
	var body: some View {
		VStack {
			HStack {
				LessBeans()
				Slider(value: $mass, in: 5...45, step: 1)
				MoreBeans()
			}
			Text("Grind \(mass, specifier: "%.f") grams of beans")
			addToRecipe()
		}
	}
	
	func addToRecipe() -> AnyView{
		return AnyView(
			Button(action:
				{ self.recipe.steps.append(RecipeStep(kindOfStep: .grind(mass: Int(self.mass)),isCombinable: true))
					self.showPopover = false
					self.showSettings = false
			}) { Text("Add to Recipe") }
		)
	}
}

struct LessBeans: View {
    var body: some View {
        HStack {
            Image(systemName: "speaker.zzz")
//            Image(systemName: "moon.zzz")
//            Image(systemName: "zzz")
        }.padding()
    }
}

struct MoreBeans: View {
    var body: some View {
        HStack {
            Image(systemName: "speaker.3")
        }.padding()
    }
}

struct Grind_Previews: PreviewProvider {
	@State private static var fakeRecipe = Recipe(name: "FakeRecipe")
	@State private static var fakeShowPopover = true
	@State private static var fakeShowSettings = true
    static var previews: some View {
        List{
			GrindForSettings(recipe: $fakeRecipe, showPopover: $fakeShowPopover, showSettings: $fakeShowSettings)
			GrindForList(mass: 15)
			GrindForRecipe(mass: 15)
        }
    }
}
