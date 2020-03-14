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
	@Binding var showPopover: Bool
	@Binding var showSettings: Bool
	
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
				{ self.recipe.steps.append(RecipeStep(kindOfStep: .plunge(seconds: Int(self.duration)),isCombinable: false))
					self.showPopover = false
					self.showSettings = false
			}) { Text("Add to Recipe") }
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
    @Binding var timeElapsedSec: CGFloat
    var totalTimeSec : CGFloat

    var body: some View {
        VStack{
            HStack{
                // RESPONSIVE PROGRESS BAR VIEW
                TimerPillStep(timeElapsedSec: $timeElapsedSec, timeDurationSec: totalTimeSec)
                Spacer()
                // WAIT STEP CONTENT
                VStack {
                    Text("Plunge over \(Int(totalTimeSec), specifier: "%d") seconds").font(.title).padding()
                        
                    Stopwatch(timeElapsedSec: $timeElapsedSec, timeDurationSec: totalTimeSec).padding()
                    
                }
                Spacer()
            }
        }
		.recipeStepContainer()
    }
}

struct Plunge_Previews: PreviewProvider {
	@State private static var fakeRecipe = Recipe(name: "FakeRecipe")
	@State private static var fakeShowPopover = true
	@State private static var fakeShowSettings = true
    @State private static var fakeElapsedTime: CGFloat = 5
	private static let fakeTotalTime: CGFloat = 9
	static var previews: some View {
        List{
			PlungeForSettings(recipe: $fakeRecipe, showPopover: $fakeShowPopover, showSettings: $fakeShowSettings)
			PlungeForList(duration: 20)
			PlungeForRecipe(timeElapsedSec: $fakeElapsedTime, totalTimeSec: fakeTotalTime)
        }
    }
}
