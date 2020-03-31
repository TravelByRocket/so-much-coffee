//
//  EventsPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/31/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct EventsPage: View {
	@EnvironmentObject var allShops: Shops
	
	var eventShops: Shops {
		let filtered = allShops.items.filter { $0.events != "" }
		return Shops(shops: filtered)
	}
	
	var body: some View {
		NavigationView {
			VStack {
				MapView(shops: eventShops, centerCoordinate: eventShops.centerOfShops, latitudeDelta: eventShops.latitudeDeltaOfShops, longitudeDelta: eventShops.longitudeDeltaOfShops)
					.navigationBarTitle("Find Events")
					.navigationBarItems(trailing: GoHome())
				
				// BROKEN
				//				List(eventShops.allWithinMapAreaSortedComputed, id: \.shop.id) {shop in
				//					NavigationLink(destination: ShopView(shop: shop.shop)) {
				//						ShopRow(shop: shop)
				//					}
				//				}
				
				// WORKING ICOMPLETE
				List(eventShops.items.sorted()) {shop in
					NavigationLink(destination: ShopView(shop: shop)) {
						Text(shop.name)
					}
				}
				
				// BROKEN
				//				ForEach(eventShops.allWithinMapAreaSortedComputed, id: \.shop.id) {shop in
				//					NavigationLink(destination: ShopView(shop: shop.shop)) {
				//						ShopRow(shop: shop)
				//					}
				//				}
				
//				// TESTING
//				List (allShops.allWithinMapAreaSorted.filter { $0.shop.roastsOwn ?? false }, id: \.shop.id) {shop in
//					NavigationLink (destination: ShopView(shop: shop.shop)){
//						ShopRow(shop: shop) // location for distance is provided through the Shops class
//					}
//				}
			}
		}
	}
}

struct EventsPage_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			EventsPage()
				.environmentObject(Shops())
		}
	}
}
