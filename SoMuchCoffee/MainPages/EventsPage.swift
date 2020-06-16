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
	let bufferFactor = 1.2
	
	@EnvironmentObject var mapStatus: MapStatusManager
	
	var body: some View {
		NavigationView {
			VStack {
				ZStack {
					MapView(shops: eventShops, centerCoordinate: eventShops.centerCoordinate, latitudeDelta: eventShops.latitudeDelta, longitudeDelta: eventShops.longitudeDelta)
						.edgesIgnoringSafeArea(.bottom)
						.navigationBarTitle("Shops with Events")
						.navigationBarItems(leading: ShowHideList(showList: $showList), trailing: GoHome())
					Image(systemName: "smallcircle.circle").opacity(0.7)
				}
				if showList {
					List (Array(eventShops).filter({$0.isInMapRect}).sorted(by: { (first, second) -> Bool in
						first.kilometersAway(from: mapStatus.centerCoordinate) < second.kilometersAway(from: mapStatus.centerCoordinate)
					})) {shop in
						NavigationLink (destination: ShopPage(shop: shop)){
							VStack {
								ShopRow(shop: shop)
							}
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
