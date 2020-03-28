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
	var shop: Shop
	
	var body: some View {
		VStack {
			MapView(shopContainer: Shops(oneShop: shop), centerCoordinate: shop.latlon, latlonDelta: 0.01, showMarker: true)
				.navigationBarTitle(shop.name)
			List {
				Section (header: Text("Support During COVID-19")) {
					Text("Notes about where to order coffee, tip baristas, etc.")
				}
				Section (header: Text("Coffee Served")) {
					Text("Espresso X served every day")
					Text("Espresso Y served Mon-Thu")
					Text("A single-origin espresso is served Fri-Sun")
				}
				Section (header: Text("Supplying Roasters")) {
					ForEach ([shop.roasters], id: \.self) {roaster in
						Text("\(roaster ?? "unknown")")
					}
				}
				Section (header: Text("Atmosphere & Features")) {
					Text("(Range of beverages)")
					Text("(Food)")
					Text("(WiFi)")
					Text("(Power Outlets)")
					Text("(Good for studying)")
					Text("(Good for socializing)")
				}
				Section (header: Text("Online & Social")) {
					HStack {
						FontAwesomeIcon(name: .globe, type: .solid)
						Text(shop.website ?? "none")
						ActionIndicator()
					}
					HStack {
						FontAwesomeIcon(name: .instagram, type: .brands)
						Text("@\(shop.instagram ?? "unknown")")
						ActionIndicator()
					}
					HStack {
						FontAwesomeIcon(name: .twitter, type: .brands)
						Text("@\(shop.twitter ?? "unknown")")
						ActionIndicator()
					}
					// Sending people to Foursquare might bely my intentions
					HStack {
						FontAwesomeIcon(name: .foursquare, type: .brands)
						Text("View on Foursquare").italic()
						ActionIndicator()
					}
					// Maybe combine with address row
					HStack {
						FontAwesomeIcon(name: .google, type: .brands)
						Text("View on Google Maps").italic()
						ActionIndicator()
					}
					// Maybe combine with address row
					HStack {
						FontAwesomeIcon(name: .apple, type: .brands)
						Text("View on Apple Maps").italic()
						ActionIndicator()
					}
				}
				Section (header: Text("Contact")) {
					AddressRow(addr: shop.address)
					PhoneNumberRow(phone: shop.phone)
					ScheduleRow(sched: shop.hours)
					EmailRow(email: shop.email)
				}
				Section (header: Text("Other")) {
					EmailCorrectionRow()
				}
				
			}
		}
	}
}

struct ShopView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ShopView(shop: Shop(id: "anything", name: "Some Great Place", address: "1234 Here St", latitude: 40, longitude: 104))
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
	let addr: String?
	var body: some View {
		HStack {
			Image(systemName: "map")
			Text(addr ?? "Not available")
			Spacer()
			CopyFieldToClipboard(string: addr)
		}
	}
}

struct PhoneNumberRow: View {
	let phone: String?
	var phoneFormatted: String {
		var formatted = ""
		if let phone = phone {
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
				Image(systemName: "phone")
				if phone != nil { // if phone is not nil
					HStack {
						Text(phoneFormatted) // then show the formatted phone number
						ActionIndicator() // and the indicator that it will do an action if clicked
					}
					.onTapGesture {
						callPhoneNumber(number: self.phone!) // and make a call if clicked
					}
				} else { // otherwise if phone is nil then just show that it's not set
					Text("No phone number set").italic()
				}
			}
			Spacer()
			CopyFieldToClipboard(string: phone)
		}
	}
}

struct EmailRow: View {
	let email: String?
	var body: some View {
		HStack {
			HStack {
				Image(systemName: "envelope")
				if email != nil { // if phone is not nil
					HStack {
						Text(email!) // then show the formatted phone number
						ActionIndicator() // and the indicator that it will do an action if clicked
					}
					.onTapGesture {
						sendEmail(addr: self.email!) // and make a call if clicked
					}
				} else { // otherwise if phone is nil then just show that it's not set
					Text("No email address set").italic()
				}
				ActionIndicator()
			}
			Spacer()
			CopyFieldToClipboard(string: self.email)
		}
	}
}

struct ScheduleRow: View {
	let sched: String?
	var body: some View {
		HStack {
			Image(systemName: "calendar")
			Text(sched ?? "No hours set")
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

struct FontAwesomeIcon: View {
	let name: FontAwesome
	let type: FontAwesomeStyle
	
	var body: some View {
		Image(uiImage: UIImage.fontAwesomeIcon(
			name: name,
			style: type,
			textColor: .black,
			size: CGSize(width: 25, height: 25)))
			.padding(2)
			.background(Color.white)
			.mask(RoundedRectangle(cornerRadius: 3.0))
			.padding(.leading,-5)
	}
}
