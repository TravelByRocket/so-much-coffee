//
//  RoasterView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/29/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RoasterViewJSON: View {
	var roaster: RoasterJSON
	
	@EnvironmentObject var allShops: Shops
	
	var allCoffees: [CoffeeJSON] = Coffees.everyFromJSON
	var allOrigins: Origins = Origins.all
	
	var filteredShops: Shops {
		let filtered = allShops.shopsServing(roasterID: roaster.id)
		return Shops(shops: filtered)
	}
	
    var body: some View {
		VStack {
			MapViewJSON(shops: filteredShops, centerCoordinate: filteredShops.centerOfShops, latitudeDelta: filteredShops.latitudeDeltaOfShops, longitudeDelta: filteredShops.longitudeDeltaOfShops)
			Text(roaster.name).font(.title).multilineTextAlignment(.center).padding(.horizontal)
			Text(roaster.description).multilineTextAlignment(.leading).padding(.horizontal)
			List {
				Section (header: Text("Locations Serving")) {
					ForEach (filteredShops.items.sorted(), id: \.id) {shop in
						NavigationLink(destination: ShopViewJSON(shop: shop)) {
							DetailRowDisplayOnly(symbol: (shop.roastsOwn ?? false ? "link.circle.fill" : "smallcircle.fill.circle"), str: shop.name)
						}
					}
				}
				Section (header: Text("Roasts")) {
					ForEach(allCoffees.filter { $0.roasterID == roaster.id }.sorted(), id: \.self) {coffee in
						NavigationLink(destination: CoffeePageJSON(coffee: coffee)) {
							VStack (alignment: .leading) {
								Text(coffee.name)
								Text(self.allOrigins.originFromID(coffee.originID).name)
									.foregroundColor(Color.secondary)
									.font(.caption)
							}
						}
					}
				}
				Section (header: Text("More Details")){
					InstagramRow(instagramHandle: roaster.instagram)
					DetailRowDisplayOnly(symbol: "equal.circle.fill", str: ("Fair Trade: "+roaster.fairtrade))
					DetailRowDisplayOnly(symbol: "dollarsign.square.fill", str: ("Offer: "+roaster.code))
					DetailRowDisplayOnly(symbol: "barcode", str: ("Code: "+roaster.code))
					DetailRowActionableFA(name: .globe, type: .solid, str: "Order Beans", url: roaster.ordering, rawString: roaster.ordering, noun: "ordering")
					DetailRowActionableFA(name: .globe, type: .solid, str: "Bean Subscription", url: roaster.ordering, rawString: roaster.subscription, noun: "subscription")
				}
			}
		}
		.edgesIgnoringSafeArea(.top)
    }
}

struct RoasterViewJSON_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			RoasterViewJSON(roaster: RoasterJSON(id: "sweetbloom", name: "Fake Sweet Bloom", description: "Using energy from the Sun", instagram: "sunny"))
//			Text("placeholder")
		}
		.environmentObject(Shops())
		.navigationBarTitle("Shop Name")
    }
}
