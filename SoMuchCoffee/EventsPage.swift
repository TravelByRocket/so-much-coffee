//
//  EventsPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/31/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI
import RealmSwift

struct EventsPage: View {
	let eventShops = realm.objects(Shop.self).filter("eventsURL CONTAINS 'http'")
	@State private var showList = true
	
	var body: some View {
		NavigationView {
			VStack {
				ZStack {
					MapViewResults(shops: eventShops, centerCoordinate: eventShops.centerCoordinate, latitudeDelta: eventShops.latitudeDelta, longitudeDelta: eventShops.longitudeDelta)
						.edgesIgnoringSafeArea(.bottom)
						.navigationBarTitle("Shops with Events")
						.navigationBarItems(leading: ShowHideList(showList: $showList), trailing: GoHome())
					Image(systemName: "smallcircle.circle").opacity(0.7)
				}
				if showList {
					List (eventShops) {shop in
						NavigationLink (destination: ShopPage(shop: shop)){
							VStack (alignment: .leading){
								Text(shop.name)
								Text("fix ShopRow needing distance as Shop").foregroundColor(.secondary).italic().font(.caption)
//								ShopRow(shop: shop) // location for distance is provided through the Shops class
							}
						}
					}
					.id(UUID())
				}
			}
			.animation(.default)
		}
	}
}

struct EventsPage_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			EventsPage()
		}
	}
}
