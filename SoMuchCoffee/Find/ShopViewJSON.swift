//
//  ShopView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/24/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI
import FontAwesome_swift

struct ShopViewJSON: View {
	@EnvironmentObject var currentShop: ReportingShopJSON
	@EnvironmentObject var allShops: Shops
	@EnvironmentObject var allRoasters: Roasters
	var shop: ShopJSON

	var body: some View {
		VStack {
			MapViewJSON(shops: Shops(oneShop: shop), centerCoordinate: shop.latlon, latitudeDelta: 0.015, longitudeDelta: 0.015)
				.onAppear() {
					self.currentShop.shop = self.shop
			}
			Text(shop.name).font(.title).multilineTextAlignment(.center).padding(.horizontal)
			Text(shop.summary).multilineTextAlignment(.leading).padding(.horizontal)
			List {
				Section (header: Text("Support During COVID-19 Stay at Home Order")) {
					DetailRowDisplayOnly(symbol: "message.fill", str: shop.stayAtHomeOrderNote)
				}
				Section (header: Text("Supplying Roasters")) {
					ForEach (shop.roasters.components(separatedBy: ","), id: \.self) {roasterID in
						NavigationLink(destination: RoasterViewJSON(roaster: self.allRoasters.roasterFromID(roasterID))) {
							DetailRowDisplayOnly(symbol: self.allShops.shopCountToCircleStringName(roasterID), str: self.allRoasters.roasterNameFromID(roasterID))
						}
					}
				}
				Section (header: Text("Atmosphere & Features")) {
					DetailRowActionableFA(name: .calendarCheck, type: .regular, str: "Events Page", url: shop.events, rawString: shop.events, noun: "event")
					DetailRowDisplayOnlyFA(name: .glassWhiskey, type: .solid, str: shop.beverages, noun: "beverage")
					DetailRowDisplayOnlyFA(name: .utensils, type: .solid, str: shop.food, noun: "food")
					DetailRowDisplayOnlyFA(name: .wifi, type: .solid, str: shop.wifi, noun: "wifi")
					DetailRowDisplayOnlyFA(name: .plug, type: .solid, str: shop.power, noun: "power outlet")
					DetailRowDisplayOnlyFA(name: .userFriends, type: .solid, str: shop.socializing, noun: "socializing")
					DetailRowDisplayOnlyFA(name: .book, type: .solid, str: shop.working, noun: "working/studying")

				}
				Section (header: Text("Online & Social")) {
					WebsiteRow(url: shop.website)
					InstagramRow(instagramHandle: shop.instagram)
//					DetailRowActionableFA(name: .twitter, type: .brands, str: "@\(shop.twitter)", url: "https://twitter.com/\(shop.twitter)", rawString: shop.twitter)
					// Sending people to Foursquare might bely my intentions
//					DetailRowActionableFA(name: .foursquare, type: .brands, str: "View on Foursquare", url: shop.foursquare, rawString: shop.foursquare)
					// Maybe combine with address row
//					DetailRowActionableFA(name: .google, type: .brands, str: "View on Google Maps", url: "http://maps.google.com", rawString: "")
					// Maybe combine with address row
//					DetailRowActionableFA(name: .apple, type: .brands, str: "View on Apple Maps", url: "http://maps.apple.com", rawString: "")
				}
				Section (header: Text("Contact")) {
					AddressRow(addr: shop.address)
					PhoneNumberRow(phone: shop.phone)
					DetailRowDisplayOnly(symbol: "clock.fill", str: shop.hours)
					EmailRow(email: shop.email)
				}
				Section (header: Text("Other")) {
					EmailCorrectionRow()
				}

			}
		}
		.edgesIgnoringSafeArea(.top)
	}
}

struct ShopViewJSON_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ShopViewJSON(shop: Shops.oneFromJSON)
			.environmentObject(ReportingShopJSON())
			.environmentObject(Roasters.all)
			.environmentObject(Shops.all)
		}
	}
}


