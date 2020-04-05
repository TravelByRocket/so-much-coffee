//
//  EventsPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/31/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct EventsPage: View {
	@State private var showList = true
	@ObservedObject private var eventShops: Shops = Shops(shops: Shops.everyFromJSON.filter { $0.events != "" })
	
	var body: some View {
		NavigationView {
			VStack {
				ZStack {
					MapView(shops: eventShops, centerCoordinate: eventShops.centerOfShops, latitudeDelta: eventShops.latitudeDeltaOfShops, longitudeDelta: eventShops.longitudeDeltaOfShops)
						.edgesIgnoringSafeArea(.bottom)
						.navigationBarTitle("Find Events")
						.navigationBarItems(leading: ShowHideList(showList: $showList), trailing: GoHome())
					Image(systemName: "smallcircle.circle").opacity(0.7)
				}
				if showList {
					List (eventShops.allWithinMapAreaSorted, id: \.shop.id) {shop in
						NavigationLink (destination: ShopView(shop: shop.shop)){
							ShopRow(shop: shop) // location for distance is provided through the Shops class
						}
					}
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
