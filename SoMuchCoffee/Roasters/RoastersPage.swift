//
//  RoastersPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/24/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RoastersPage: View {
	@EnvironmentObject var allShops: Shops
	@EnvironmentObject var allRoasters: Roasters
	
	@State private var searchString = ""
	
	private var filteredRoasters: [Roaster] {
		if searchString == "" {
			return allRoasters.items.sorted()
		} else {
			return allRoasters.items.sorted().filter { $0.name.lowercased().contains(searchString.lowercased()) }
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
					NavigationLink(destination: RoasterView(roaster: roaster)) {
						HStack {
							Image(systemName: self.allShops.shopCountToCircleStringName(roaster.id))
							Text(roaster.name)
						}
					}
				}
			}
			.navigationBarTitle("Roasters")
			.navigationBarItems(trailing: GoHome())
		}
    }
	
//	func shopCountToCircleStringName(_ roaster: Roaster) -> String {
//		let count = self.allShops.shopsServing(roasterID: roaster.id).count
//		if count <= 50 {
//			return String(count) + ".circle"
//		} else {
//			return "asterisk.circle"
//		}
//	}
}

struct RoastersPage_Previews: PreviewProvider {
    static var previews: some View {
		RoastersPage()
		.environmentObject(Shops())
		.environmentObject(Roasters())
    }
}
