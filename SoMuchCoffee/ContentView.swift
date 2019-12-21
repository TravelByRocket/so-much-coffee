//
//  ContentView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/9/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

//var appOrange:    Color = Color.init(red: 1.00, green: 0.34, blue: 0.13)
var appOrange50:  Color = Color.init(red: 1.00, green: 0.67, blue: 0.26)
var appBlue:      Color = Color.init(red: 0.26, green: 0.52, blue: 0.97)
var appDarkGray:  Color = Color.init(red: 0.66, green: 0.66, blue: 0.66)
var appLightGray: Color = Color.init(red: 0.90, green: 0.90, blue: 0.90)
var transparent:  Color = Color.init(red: 0.00, green: 0.00, blue: 0.00, opacity: 0.00)
//let largeTitle:   Font  = Font.custom("AlfaSlabOne", size: 20)
let alfa: String = "AlfaSlabOne-Regular"
let lato: String = "Lato-Light"
let monoregular: String = "B12Mono-Regular"
let monobold: String = "B12Mono-Bold"
let timerInterval: CGFloat = 0.05

struct ContentView: View {
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
    
        VStack{
            if settings.curPage == "MAIN" {
                MainPage()
            } else if settings.curPage == "BREW" {
               RecipesView()
            } else if settings.curPage == "RECIPECONDUCTOR" {
                RecipeConductor()
            } else if settings.curPage == "RECIPEBUILDER" {
                RecipeBuilder()
            } else if settings.curPage == "APSTEPS" {
                RecipeBuilder()
            }
            else {
                ZStack{
                    MainPage()
                    VStack {
                        Spacer()
                        Text("Section Does not Exist Yet")
                            .foregroundColor(Color.red)
                        Text("HINT: Click on Brew")
                            .foregroundColor(Color.red)
                    }.padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserSettings())
    }
}

class UserSettings: ObservableObject {
    @Published var curPage = "MAIN"
}

extension Color {
    static let appOrange = Color("appOrange")
}
