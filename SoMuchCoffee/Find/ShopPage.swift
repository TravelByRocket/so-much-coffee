//
//  ShopView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 6/11/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI
import RealmSwift
import FontAwesome_swift

struct ShopPage: View {
	@EnvironmentObject var currentShop: ReportingShop // TODO replace this by passing entire Shop object into each subview and then handle everything within that view, including a way to report an error, though that will itself be done with some common element
	var shop: Shop
	
	var body: some View {
		VStack {
			MapViewShop(shop: shop, centerCoordinate: shop.latlon, latitudeDelta: 0.015, longitudeDelta: 0.015)
				.onAppear() {
					self.currentShop.shop = self.shop
			}
			Text(shop.name).font(.title).multilineTextAlignment(.center).padding(.horizontal)
			Text(shop.summary ?? "No summary yet").multilineTextAlignment(.leading).padding(.horizontal)
			List {
				Section (header: Text("Support During COVID-19 Stay at Home Order")) {
					DetailRowDisplayOnly(symbol: "message.fill", str: shop.stayAtHomeOrderNote ?? "")
				}
				Section (header: Text("Supplying Roasters")) {
					ForEach (shop.roasters) {roaster in
						NavigationLink(destination: RoasterPage(roaster: roaster)) {
							DetailRowDisplayOnly(symbol: String(roaster.shopsServing.count) + ".circle" , str: roaster.name)
						} // TODO make this circle part of an extension
					}
				}
				Section (header: Text("Atmosphere & Features")) {
					DetailRowActionableFA(name: .calendarCheck, type: .regular, str: "Events Page", url: shop.eventsURL ?? "", rawString: shop.eventsURL ?? "", noun: "event")
					DetailRowDisplayOnlyFA(name: .glassWhiskey, type: .solid, str: shop.beveragesNote ?? "", noun: "beverage")
					DetailRowDisplayOnlyFA(name: .utensils, type: .solid, str: shop.foodNote ?? "", noun: "food")
					DetailRowDisplayOnlyFA(name: .wifi, type: .solid, str: shop.wifiNote ?? "", noun: "wifi")
					DetailRowDisplayOnlyFA(name: .plug, type: .solid, str: shop.powerOutlets ?? "", noun: "power outlet")
					DetailRowDisplayOnlyFA(name: .userFriends, type: .solid, str: shop.atmosphereSocial ?? "", noun: "socializing")
					DetailRowDisplayOnlyFA(name: .book, type: .solid, str: shop.atmosphereWork ?? "", noun: "working/studying")
//
				}
				Section (header: Text("Online & Social")) {
					WebsiteRow(url: shop.website ?? "")
					InstagramRow(instagramHandle: shop.instagram ?? "")
////					DetailRowActionableFA(name: .twitter, type: .brands, str: "@\(shop.twitter)", url: "https://twitter.com/\(shop.twitter)", rawString: shop.twitter)
//					// Sending people to Foursquare might bely my intentions
////					DetailRowActionableFA(name: .foursquare, type: .brands, str: "View on Foursquare", url: shop.foursquare, rawString: shop.foursquare)
//					// Maybe combine with address row
////					DetailRowActionableFA(name: .google, type: .brands, str: "View on Google Maps", url: "http://maps.google.com", rawString: "")
//					// Maybe combine with address row
////					DetailRowActionableFA(name: .apple, type: .brands, str: "View on Apple Maps", url: "http://maps.apple.com", rawString: "")
				}
				Section (header: Text("Contact")) {
					AddressRow(addr: shop.address)
					PhoneNumberRow(phone: shop.phone ?? "")
					DetailRowDisplayOnly(symbol: "clock.fill", str: shop.hours ?? "")
					EmailRow(email: shop.email ?? "")
				}
				Section (header: Text("Other")) {
					EmailCorrectionRow()
				}
			}
		}
		.edgesIgnoringSafeArea(.top)
	}
}

struct ShopView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ShopPage(shop: realm.objects(Shop.self).randomElement()!)
			.environmentObject(ReportingShop())
		}
	}
}
