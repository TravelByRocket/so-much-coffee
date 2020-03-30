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
	
	var body: some View {
		NavigationView {
			VStack {
				List(allRoasters.items.sorted()) {roaster in
					NavigationLink(destination: RoasterView(roaster: roaster)) {
						HStack {
							Image(systemName: self.shopCountToCircleStringName(roaster))
							Text(roaster.name)
						}
					}
				}
			}
			.navigationBarTitle("Roasters")
			.navigationBarItems(trailing: GoHome())
		}
    }
	
	func shopCountToCircleStringName(_ roaster: Roaster) -> String {
		let count = self.allShops.shopsServing(roasterID: roaster.id).count
		if count <= 50 {
			return String(count) + ".circle"
		} else {
			return "asterisk.circle"
		}
	}
}

struct RoastersPage_Previews: PreviewProvider {
    static var previews: some View {
		RoastersPage()
		.environmentObject(Shops())
		.environmentObject(Roasters())
    }
}
