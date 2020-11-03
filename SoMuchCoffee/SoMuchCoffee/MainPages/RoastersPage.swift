//
//  RoastersPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/24/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI
import RealmSwift

struct RoastersPage: View {
	@State private var searchString = ""
    
    @EnvironmentObject var us: UserSettings
	
	// Consider other implementation from WWDC2020 Type Inference video at ~3:30-~8:30
	private var filteredRoasters: RealmSwift.Results<Roaster> {
		if searchString == "" {
			return realm.objects(Roaster.self).sorted(byKeyPath: "name")
		} else {
			return realm.objects(Roaster.self).sorted(byKeyPath: "name").filter("name CONTAINS[c] '\(searchString)'")
		}
	}
		
	var body: some View {
		NavigationView {
			List {
				TextField("Filter roaster list", text: $searchString)
					.autocapitalization(.none)
					.textFieldStyle(RoundedBorderTextFieldStyle())
				ForEach(filteredRoasters) {roaster in
					RoasterRow(roaster: roaster)
				}
                .listStyle(PlainListStyle())
			}
            .navigationBarHidden(true)
		}
    }
}

struct RoastersPage_Previews: PreviewProvider {
    static var previews: some View {
		RoastersPage()
    }
}

struct RoasterRow: View {
	var roaster: Roaster
    
    @EnvironmentObject var us: UserSettings
    
	var body: some View {
        NavigationLink(destination: RoasterPage(roaster: roaster)) {
			HStack {
                Text(roaster.name)
                Spacer()
                Image(systemName:
                    roaster.shopsServing.count <= 50 ?
                        "\(roaster.shopsServing.count).circle" :
                    "asterisk.circle"
                )
			}
		}
	}
}
