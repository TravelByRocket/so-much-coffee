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
	
	private var filteredRoasters: RealmSwift.Results<Roaster> {
		if searchString == "" {
			return realm.objects(Roaster.self).sorted(byKeyPath: "name")
		} else {
			return realm.objects(Roaster.self).sorted(byKeyPath: "name").filter("name CONTAINS[c] '\(searchString)'")
		}
	}
		
	var body: some View {
		NavigationView {
			VStack {
				TextField("Filter roaster list", text: $searchString)
					.autocapitalization(.none)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.padding(.horizontal)
				List(filteredRoasters) {roaster in
					RoasterRow(roaster: roaster)
				}
			}
			.navigationBarTitle("Roasters")
			.navigationBarItems(trailing: GoHome())
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
	var body: some View {
		NavigationLink(destination: RoasterView(roaster: roaster)) {
			HStack {
				Image(systemName:
					roaster.shopsServing.count <= 50 ?
						"\(roaster.shopsServing.count).circle" :
					"asterisk.circle"
				)
				Text(roaster.name)
			}
		}
	}
}
