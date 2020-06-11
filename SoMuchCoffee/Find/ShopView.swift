//
//  ShopView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/24/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI
import FontAwesome_swift

struct ShopView: View {
	@EnvironmentObject var currentShop: ReportingShop
	@EnvironmentObject var allShops: Shops
	@EnvironmentObject var allRoasters: Roasters
	var shop: Shop
	
	var body: some View {
		VStack {
			MapView(shops: Shops(oneShop: shop), centerCoordinate: shop.latlon, latitudeDelta: 0.015, longitudeDelta: 0.015)
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
						NavigationLink(destination: RoasterView(roaster: self.allRoasters.roasterFromID(roasterID))) {
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

struct ShopView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ShopView(shop: Shops.oneFromJSON)
			.environmentObject(ReportingShop())
			.environmentObject(Roasters.all)
			.environmentObject(Shops.all)
		}
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
					NotAvailable()
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
					NotAvailable()
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

// String extension to use integers for subscripting
// https://stackoverflow.com/questions/45497705/subscript-is-unavailable-cannot-subscript-string-with-a-countableclosedrange
extension String {
	subscript (bounds: CountableClosedRange<Int>) -> String {
		let start = index(startIndex, offsetBy: bounds.lowerBound)
		let end = index(startIndex, offsetBy: bounds.upperBound)
		return String(self[start...end])
	}
	
	subscript (bounds: CountableRange<Int>) -> String {
		let start = index(startIndex, offsetBy: bounds.lowerBound)
		let end = index(startIndex, offsetBy: bounds.upperBound)
		return String(self[start..<end])
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
				NotAvailable(detail: noun)
			}
		}.sheet(isPresented: $showSheet, content: { SafariView(url: URL(string: self.url)!) } )
	}
}



class ReportingShop: ObservableObject {
	@Published var shop: Shop?
}


struct InstagramRow: View {
	let instagramHandle: String
	var body: some View {
		DetailRowActionableFA(name: .instagram, type: .brands, str: "@\(instagramHandle)", url: "https://instagram.com/\(instagramHandle)", rawString: instagramHandle)
	}
}

