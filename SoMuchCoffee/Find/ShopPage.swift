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

struct CopyFieldToClipboard: View {
	// view disables itself if string = nil
	let string: String?
	var body: some View {
		Image(systemName: "doc.on.doc")
			.padding(.vertical,10)
			.padding(.horizontal,7)
			.background(Color.gray.opacity(0.2))
			.mask(RoundedRectangle(cornerRadius: 3.0))
			.onTapGesture {
				UIPasteboard.general.string = self.string
		}
		.disabled(string == nil)
	}
}

struct ActionIndicator: View {
	var body: some View {
		Image(systemName: "chevron.right.circle")
	}
}

struct AddressRow: View {
	let addr: String
	var body: some View {
		HStack {
			Image(systemName: "map.fill")
			Text(addr)
			Spacer()
			CopyFieldToClipboard(string: addr)
		}
	}
}

struct PhoneNumberRow: View {
	let phone: String
	var phoneFormatted: String {
		var formatted = ""
		if phone != "" {
			formatted += "+1 ("
			formatted += phone[0..<3]
			formatted += ") "
			formatted += phone[3..<6]
			formatted += "-"
			formatted += phone[6..<10]
		}
		return formatted
	}
	var body: some View {
		HStack {
			HStack {
				Image(systemName: "phone.fill")
				if phone != "" { // if phone is not empty
					HStack {
						Text(phoneFormatted) // then show the formatted phone number
						ActionIndicator() // and the indicator that it will do an action if clicked
					}
					.onTapGesture {
						callPhoneNumber(number: self.phone) // and make a call if clicked
					}
				} else { // otherwise if phone is blank then just show that it's not set
					NotAvailableJSON()
				}
			}
			Spacer()
			CopyFieldToClipboard(string: phone)
		}
	}
}

struct EmailRow: View {
	let email: String
	var body: some View {
		HStack {
			HStack {
				Image(systemName: "at")
				if email != "" { // if phone is not nil
					HStack {
						Text(email) // then show the formatted phone number
						ActionIndicator() // and the indicator that it will do an action if clicked
					}
					.onTapGesture {
						sendEmail(addr: self.email) // and make a call if clicked
					}
				} else { // otherwise if phone is empty then just show that it's not set
					NotAvailableJSON()
				}
			}
			Spacer()
			CopyFieldToClipboard(string: self.email)
		}
	}
}

struct ScheduleRow: View {
	let sched: String
	var body: some View {
		HStack {
			Image(systemName: "calendar")
			Text(sched != "" ? sched : "No hours set")
			Spacer()
		}
	}
}

struct EmailCorrectionRow: View {
	var body: some View {
		HStack {
			Image(systemName: "exclamationmark.square.fill")
			Text("Correction? Send us an email!")
				.italic()
			ActionIndicator()
		}
		.foregroundColor(Color.orange)
		.onTapGesture {
			sendEmail(addr: "app@somuchcoffee.co")
		}
	}
}

func callPhoneNumber(number: String) {
	// https://stackoverflow.com/questions/27259824/calling-a-phone-number-in-swift
	if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
		if #available(iOS 10, *) {
			UIApplication.shared.open(url)
		} else {
			UIApplication.shared.openURL(url)
		}
	}
}

func sendEmail(addr: String) {
	if let url = URL(string: "mailto:\(addr)"), UIApplication.shared.canOpenURL(url) {
		if #available(iOS 10, *) {
			UIApplication.shared.open(url)
		} else {
			UIApplication.shared.openURL(url)
		}
	}
}

struct DetailRowActionableFA: View {
	@State private var showSheet = false
	let name: FontAwesome
	let type: FontAwesomeStyle
	let str: String
	let url: String
	let rawString: String
	var noun: String = ""
	
	var body: some View {
		HStack {
			FontAwesomeIcon(name: name, type: type)
			if (rawString != "") {
				HStack {
					Text(str)
					ActionIndicator()
				}.onTapGesture {
					self.showSheet = true
				}
			} else {
				NotAvailableJSON(detail: noun)
			}
		}.sheet(isPresented: $showSheet, content: { SafariView(url: URL(string: self.url)!) } )
	}
}

struct InstagramRow: View {
	let instagramHandle: String
	var body: some View {
		DetailRowActionableFA(name: .instagram, type: .brands, str: "@\(instagramHandle)", url: "https://instagram.com/\(instagramHandle)", rawString: instagramHandle)
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

// DELETE THIS WHEN POSSIBLE
class ReportingShop: ObservableObject {
	@Published var shop: Shop?
}
