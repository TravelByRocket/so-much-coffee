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
	@EnvironmentObject var allShops: Shops
	
	var filteredShops: Shops {
		let filtered = allShops.shopsServing(roasterID: roaster.id)
		return Shops(shops: filtered)
	}
	
    var body: some View {
		VStack {
			MapView(shopContainer: filteredShops, centerCoordinate: filteredShops.centerOfShops, latlonDelta: filteredShops.latlonDeltaOfShops)
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
			RoasterView(roaster: Roaster(id: "sweetbloom", name: "Fake Sweet Bloom", description: "Using energy from the Sun", instagram: "sunny"))
		}
		.environmentObject(Shops())
		.navigationBarTitle("Shop Name")
    }
}
