//
//  ContentView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/9/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
	@EnvironmentObject var settings: UserSettings
	
	var body: some View {
		
		VStack{
			if settings.curPage == "MAIN" {
				HomeTab()
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
    @Published var curTab: Views = .shops
    var curShop: Shop?
    var curRoaster: Roaster?
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
