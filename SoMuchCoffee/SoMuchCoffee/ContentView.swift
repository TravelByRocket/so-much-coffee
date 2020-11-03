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
        HomeTab()
	}
	
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
            .environmentObject(UserSettings())
	}
}

class UserSettings: ObservableObject {
    @Published var curTab: Views = .shops
}
