//
//  Stir.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/4/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct StirForRecipe: View {
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
                    Text("Stir for \(Int(totalTimeSec), specifier: "%d") seconds").font(.title).padding()
                        
                    Stopwatch(timeElapsedSec: $timeElapsedSec, timeDurationSec: totalTimeSec).padding()
                    
                }
                Spacer()
            }
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black).foregroundColor(transparent))
        }
        .padding()
    }
}

struct StirForSettings: View {
	@Binding var recipe: Recipe // NOTE this should probably be environment object
	@Binding var showPopover: Bool
	@Binding var showSettings: Bool
	
    @State private var duration: Double = 20
    var body: some View {
        VStack {
            HStack {
                LessTime()
                Slider(value: $duration, in: 5...45, step: 1)
                MoreTime()
            }
            Text("Stir \(duration, specifier: "%.f") seconds")
			addToRecipe()
        }
    }
	
	func addToRecipe() -> AnyView{
		return AnyView(
			Button(action:
				{ self.recipe.steps.append(RecipeStep(kindOfStep: .stir(seconds: Int(self.duration)),isCombinable: false))
					self.showPopover = false
					self.showSettings = false
			}) { Text("Add to Recipe") }
		)
	}
}

struct StirForList: View {
    let duration: Int
    var body: some View {
        VStack {
			Text("Stir ")+Text("\(duration)").underline()+Text(" seconds")
        }
    }
}

struct Stir_Previews: PreviewProvider {
	@State private static var fakeRecipe = Recipe(name: "FakeRecipe")
	@State private static var fakeShowPopover = true
	@State private static var fakeShowSettings = true
    @State private static var fakeElapsedTime: CGFloat = 5
    private static let fakeTotalTime: CGFloat = 9
    static var previews: some View {
		List{
			StirForSettings(recipe: $fakeRecipe, showPopover: $fakeShowPopover, showSettings: $fakeShowSettings)
			StirForList(duration: 15)
			StirForRecipe(timeElapsedSec: $fakeElapsedTime, totalTimeSec: fakeTotalTime)
		}
    }
}
