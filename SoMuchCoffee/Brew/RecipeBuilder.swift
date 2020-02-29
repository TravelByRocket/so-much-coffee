//
//  RecipeBuilder.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/9/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RecipeBuilder: View {
	
    @State private var recipeName: String = ""
    @State private var isSelectedUpright: Bool = false
    @State private var isSelectedInverted: Bool = false
    @State private var isSelectedPaper: Bool = false
    @State private var isSelectedMetal: Bool = false
    @State private var canAddSteps: Bool = false
    @State private var showStepsPopover: Bool = false
	
	@State private var recipe: Recipe = Recipe(name: "Tester")
	@State private var testArray = ["first","second","third"]
    
//	NOTE Seems this might be good place to implement Modal sheet
	
    var body: some View {
        ZStack {
            VStack {
                // RECIPE NAME
                HStack {
                    TextField("Recipe Name", text: $recipeName)
					Button(action: {self.recipeName = self.randomTitle()}) {
						Image(systemName: "shuffle").rotationEffect(.degrees(180))
						Text("Generate")
					}
                }
                .padding()
                
                // SELECT UPRIGHT OR INVERTED
                HStack (spacing: 0){
                    
                    // UPRIGHT SELECTION
                    HStack {
                        Spacer()
                        Text("Upright\nMethod")
                            .font(.title)
                        Spacer()
                    }
                    .padding(.vertical, 40)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .border(Color.black, width: 1)
                    .background(isSelectedUpright ? Color(red: 147/255, green: 255/255, blue: 175/255, opacity: 1.0) : appLightGray)
                    .onTapGesture {
                        self.handleMethodSelection(methodPressed: "Upright")
                    }
                    
                    // INVERTED SELECTION
                    HStack {
                        Spacer()
                        Text("Inverted\nMethod")
                            .font(.title)
                        Spacer()
                    }
                    .padding(.vertical, 40)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .border(Color.black, width: 1)
                    .background(isSelectedInverted ? Color(red: 176/255, green: 160/255, blue: 255/255, opacity: 1.0) : appLightGray)
                    .onTapGesture {
                        self.handleMethodSelection(methodPressed: "Inverted")
                    }
                }
                .padding(.bottom)
				
                // FILTER SECTION
                HStack (spacing: 0){
                    // PAPER SELECTION
                    HStack {
                        Spacer()
                        Text("Paper Filter")
                            .font(.title)
                        Spacer()
                    }
                    .padding(.vertical, 40)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .border(Color.black, width: 1)
                    .background(isSelectedPaper ? Color(red: 255/255, green: 234/255, blue: 147/255, opacity: 1.0) : appLightGray)
                    .onTapGesture {
                        self.handleFilterSelection(filterPressed: "Paper")
                    }
                    
                    // METAL SELECTION
                    HStack {
                        Spacer()
                        Text("Metal Filter")
                            .font(.title)
                            
                        Spacer()
                    }
                    .padding(.vertical, 40)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .border(Color.black, width: 1)
                    .background(isSelectedMetal ? Color(red: 255/255, green: 160/255, blue: 147/255, opacity: 1.0) : appLightGray)
                    .onTapGesture {
                        self.handleFilterSelection(filterPressed: "Metal")
                    }
                }
                .padding(.bottom)
				
				Form{
					Section{
						Button("Add step", action: {self.recipe.addStep()})
						ForEach(self.recipe.steps, id: \.id){step in
//							Text(step.asString()) // this works
							step.asView()
						}
					}
					Section{
						Button("Add string", action: {self.testArray.append("another")})
						ForEach(testArray, id: \.self){str in
							Text(str)
						}
					}
					Text("hey")
				}
				
                if canAddSteps {
                    AddButton(isEnabled: true)
                    .onTapGesture {self.showStepsPopover = true}
                } else {
                    AddButton(isEnabled: false)
                }
                
                Spacer()
            }
            if showStepsPopover {
				APStepsPopover(showPopover: $showStepsPopover, recipe: $recipe)
            }
		}
    }
    
    func handleMethodSelection(methodPressed: String){
        // There is redundancy in this but no need to write more code to do less
        if methodPressed == "Upright"{
            isSelectedUpright = true
            isSelectedInverted = false
        }
        
        if methodPressed == "Inverted" {
            isSelectedUpright = false
            isSelectedInverted = true
        }
        
        checkInitialConditions()
    }
    
    func handleFilterSelection(filterPressed: String){
        // There is redundancy in this but no need to write more code to do less
        if filterPressed == "Paper"{
            isSelectedPaper = true
            isSelectedMetal = false
        }
        
        if filterPressed == "Metal" {
            isSelectedPaper = false
            isSelectedMetal = true
        }
        
        checkInitialConditions()
    }
    
    func checkInitialConditions(){
        canAddSteps = (isSelectedUpright || isSelectedInverted) && (isSelectedPaper || isSelectedMetal)
    }
	
	func randomTitle() -> String {
		var dateString: String {
			var dateFormatter: DateFormatter { //NOTE I don't know why the version in the documentation gives multiple errors but this closer version from HackingWithSwift works fine
				let formatter = DateFormatter()
				formatter.dateStyle = .medium
				formatter.timeStyle = .none
				return formatter
			}
			return dateFormatter.string(from: Date())
		}
		
		switch Int.random(in: 0...8) { // TODO make more completely random options
		case 0:
			return "Unbelievable Brew " + dateString
		case 1:
			return "Lucky Beans " + dateString
		case 2:
			return "Brew of Faith " + dateString
		case 3:
			return "Caffeine Healer " + dateString
		case 4:
			return "Can't Stop Brewing " + dateString
		case 5:
			return "Lucky Beans " + dateString
		case 6...8:
			var chaosName = ""
			let wordList = ["Unbelievable","Brew","Bean","Faith","Caffeine","Healer","Lucky","Energy","Morning","Anytime"]
			let wordCount = 3
			for _ in 1...wordCount {
				chaosName += wordList[Int.random(in: 0..<wordList.count)]
				chaosName += " "
			}
			chaosName += dateString
			return chaosName
		default:
			return "Dunno " + dateString
		}
		
	}
}

struct RecipeBuilder_Previews: PreviewProvider {
    static var previews: some View {
        RecipeBuilder()
    }
}

