//
//  ContentView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/9/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI
import RealmSwift

//var appOrange:    Color = Color.init(red: 1.00, green: 0.34, blue: 0.13)
var appOrange50:  Color = Color.init(red: 1.00, green: 0.67, blue: 0.26)
var appBlue:      Color = Color.init(red: 0.26, green: 0.52, blue: 0.97)
var appDarkGray:  Color = Color.init(red: 0.66, green: 0.66, blue: 0.66)
var appLightGray: Color = Color.init(red: 0.90, green: 0.90, blue: 0.90)
var transparent:  Color = Color.init(red: 0.00, green: 0.00, blue: 0.00, opacity: 0.00)
let alfa: String = "AlfaSlabOne-Regular"
let lato: String = "Lato-Light"
let monoregular: String = "B12Mono-Regular"
let monobold: String = "B12Mono-Bold"

let config = Realm.Configuration(
	// Get the URL to the bundled file
	fileURL: Bundle.main.url(forResource: "default", withExtension: "realm"),
	// Open the file in read-only mode as application bundles are not writeable
	readOnly: true)

// Open the Realm with the configuration
let realm = try! Realm(configuration: config)

struct ContentView: View {
	@EnvironmentObject var settings: UserSettings
	
	var body: some View {
		
		VStack{
			if settings.curPage == "MAIN" {
				HomePage()
			} else if settings.curPage == "FIND" {
				FindPage()
			} else if settings.curPage == "ROASTERS" {
				RoastersPage()
			} else if settings.curPage == "ORIGINS" {
				OriginsPage()
			} else if settings.curPage == "FLAVORS" {
				FlavorsPage()
			} else if settings.curPage == "EVENTS" {
				EventsPage()
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

func getDocumentsDirectory() -> URL {
	// find all possible documents directories for this user
	let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
	
	// just send back the first one, which ought to be the only one
	return paths[0]
}
