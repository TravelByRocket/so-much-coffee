//
//  RecipeBuilder.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/9/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RecipeBuilder: View {
//    var recipeName: String = "20191209222959"
    @State var isSelectedUpright: Bool = false
    @State var isSelectedInverted: Bool = false
    @State var isSelectedPaper: Bool = false
    @State var isSelectedMetal: Bool = false
    @State var canAddSteps: Bool = false
    @State var showStepsPopover: Bool = false
    
//	NOTE: Seems this might be good place to implement Modal sheet
	
    var body: some View {
        ZStack {
            VStack {
                // RECIPE NAME
                HStack {
                    Text("Recipe Name: ")
    //                TextField("on20191209", text: $recipeName)
                    Text("on20191209")
                    Spacer()
//                    GoHome()
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
                
				Toggle(isOn: $isSelectedInverted) {
				Text("Inverted")
				}
				
				
				
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

                if canAddSteps {
                    AddButton(isEnabled: true)
                    .onTapGesture {self.showStepsPopover = true}
                } else {
                    AddButton(isEnabled: false)
                }
                
                Spacer()
            }
            if showStepsPopover {
                APStepsPopover(showPopover: $showStepsPopover)
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
}

struct RecipeBuilder_Previews: PreviewProvider {
    static var previews: some View {
        RecipeBuilder()
    }
}

