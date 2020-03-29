//
//  RoasterView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/29/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RoasterView: View {
	var roaster: Roaster
	@EnvironmentObject var shops: Shops
	
    var body: some View {
		VStack {
			MapView(shopContainer: shops, centerCoordinate: shops.items[0].latlon)
			List {
				Section {
	//				Text(roaster.name)
					Text(roaster.description).font(.headline)
					InstagramRow(instagramHandle: roaster.instagram)
					DetailRowDisplayOnly(symbol: "equal.circle.fill", str: ("Fair Trade: "+roaster.fairtrade))
					DetailRowDisplayOnly(symbol: "dollarsign.square.fill", str: ("Offer: "+roaster.code))
					DetailRowDisplayOnly(symbol: "barcode", str: ("Code: "+roaster.code))
					WebsiteRow(url: roaster.ordering)
					WebsiteRow(url: roaster.subscription)
				}
			}
			.navigationBarTitle(roaster.name)
		}
    }
}

struct RoasterView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			RoasterView(roaster: Roaster(id: "anyid", name: "Space Roaster", description: "Using energy from the Sun", instagram: "sunny"))
		}
		.environmentObject(Shops())
		.navigationBarTitle("Shop Name")
    }
}
