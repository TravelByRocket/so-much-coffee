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
			MapView(shops: filteredShops, centerCoordinate: filteredShops.centerOfShops, latitudeDelta: filteredShops.latitudeDeltaOfShops, longitudeDelta: filteredShops.longitudeDeltaOfShops)
			Text(roaster.name).font(.title).multilineTextAlignment(.center)
			Text(roaster.description).multilineTextAlignment(.leading)
			List {
				Section (header: Text("Locations Serving")) {
					ForEach (filteredShops.items, id: \.id) {shop in
						NavigationLink(destination: ShopView(shop: shop)) {
							DetailRowDisplayOnly(symbol: "s.circle.fill", str: shop.name)
						}
					}
				}
				Section (header: Text("More Details")){
					InstagramRow(instagramHandle: roaster.instagram)
					DetailRowDisplayOnly(symbol: "equal.circle.fill", str: ("Fair Trade: "+roaster.fairtrade))
					DetailRowDisplayOnly(symbol: "dollarsign.square.fill", str: ("Offer: "+roaster.code))
					DetailRowDisplayOnly(symbol: "barcode", str: ("Code: "+roaster.code))
					WebsiteRow(url: roaster.ordering)
					WebsiteRow(url: roaster.subscription)
				}
			}
		}
		.edgesIgnoringSafeArea(.top)
//		.navigationBarTitle(roaster.name)
//		.navigationBarHidden(true)
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