//
//  APStepsPopover.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/10/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct APStepsPopover: View {
    @Binding var showPopover: Bool
	@Binding var recipe: Recipe
    
    @State var optHeatWater: Bool = false
    @State var optGrind: Bool = false
    @State var optAddWater: Bool = false
    @State var optStir: Bool = false
    @State var optWait: Bool = false
    @State var optPlunge: Bool = false
    
    var body: some View {
        
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
                .opacity(1)
            
            VStack{
                Text("Preparation")
                HStack{
					RecipeStepButton(message: "Heat\nWater")
						.onTapGesture{self.optHeatWater = true}
					RecipeStepButton(message: "Grind")
						.onTapGesture{self.optGrind = true}
					RecipeStepButton(message: "Rinse\nFilter")
						.onTapGesture{
							self.showPopover = false
							self.recipe.steps.append(RecipeStep(kindOfStep: .rinseFilter, isCombinable: true))
					}
                }
                .padding(.bottom)
                .padding(.top,0)
                
                Text("Process")
                HStack{
					RecipeStepButton(message: "Add\nWater")
						.onTapGesture {self.optAddWater = true}
					RecipeStepButton(message: "Stir")
						.onTapGesture {self.optStir = true}
					RecipeStepButton(message: "Wait")
						.onTapGesture {self.optWait = true}
                }
                .padding(.bottom)
                .padding(.top,0)
                
                Text("Completion")
                HStack{
					RecipeStepButton(message: "Insert\nPlunger")
						.onTapGesture {
							self.showPopover = false
							self.recipe.steps.append(RecipeStep(kindOfStep: .installPlunger, isCombinable: true))
					}
					RecipeStepButton(message: "Plunge")
						.onTapGesture {self.optPlunge = true}
					RecipeStepButton(message: "Attach\nFilter")
						.onTapGesture {
							self.showPopover = false
							self.recipe.steps.append(RecipeStep(kindOfStep: .installFilter, isCombinable: true))
					}
                }
                .padding(.bottom)
                .padding(.top,0)
                Text("Dismiss").foregroundColor(Color.blue)
                    .padding()
                    .onTapGesture {
                        self.showPopover = false
                }
//                Spacer()
            }
            
            if optHeatWater || optGrind || optAddWater || optStir || optWait || optPlunge {
                Color.white
                .edgesIgnoringSafeArea(.all)
                .opacity(1)
            }
            
            VStack{
                if optHeatWater {
					HeatWaterForSettings(recipe: $recipe, showPopover: $showPopover, showSettings: $optHeatWater)
					DismissToPopover(activeOption: $optHeatWater)
                } else if optGrind {
                    GrindForSettings(recipe: $recipe, showPopover: $showPopover, showSettings: $optGrind)
                    DismissToPopover(activeOption: $optGrind)
                } else if optAddWater {
                    AddWaterForSettings(recipe: $recipe, showPopover: $showPopover, showSettings: $optAddWater)
                    DismissToPopover(activeOption: $optAddWater)
                } else if optStir {
                    StirForSettings(recipe: $recipe, showPopover: $showPopover, showSettings: $optStir)
                    DismissToPopover(activeOption: $optStir)
                } else if optWait {
                    WaitForSettings(recipe: $recipe, showPopover: $showPopover, showSettings: $optWait)
                    DismissToPopover(activeOption: $optWait)
                } else if optPlunge {
                    PlungeForSettings(recipe: $recipe, showPopover: $showPopover, showSettings: $optPlunge)
                    DismissToPopover(activeOption: $optPlunge)
                }
                if optHeatWater || optGrind || optAddWater || optStir || optWait || optPlunge {
                    Spacer()
                }
            }
        }
    }
}

struct APStepsPopover_Previews: PreviewProvider {
    @State private static var fakeEnabler: Bool = true
	@State private static var fakeRecipe: Recipe = Recipe(name: "fakerecipe")
    static var previews: some View {
        APStepsPopover(showPopover: $fakeEnabler, recipe: $fakeRecipe)
    }
}



struct RecipeStepButton: View {
	let message: String
	
	var body: some View {
		VStack {
			Text(message)
				.multilineTextAlignment(.center)
		}
		.frame(width: 100,height: 100)
		.background(Color.white)
		.border(appDarkGray)
	}
}
