//
//  EventsPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/31/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct EventsPage: View {
	@State var eventShops: Shops = Shops(shops:
		Bundle.main.decode([Shop].self, from: "shops.json").filter { $0.events != "" }
	)
	
	var body: some View {
		NavigationView {
			VStack {
				MapView(shops: eventShops, centerCoordinate: eventShops.centerOfShops, latitudeDelta: eventShops.latitudeDeltaOfShops, longitudeDelta: eventShops.longitudeDeltaOfShops)
					.navigationBarTitle("Find Events")
					.navigationBarItems(trailing: GoHome())
				
				// WORKING ICOMPLETE
				List(eventShops.items.sorted()) {shop in
					NavigationLink(destination: ShopView(shop: shop)) {
						Text(shop.name)
					}
				}
			}
		}
	}
}

struct EventsPage_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			EventsPage(eventShops: Shops.example)
		}
	}
}
