//
//  ShopView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/24/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

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
						Text("\(roaster)")
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
					Text("Website: \(shop.website)")
					Text("Instagram: \(shop.instagram)")
					// Text("Facebook: ") FB is a mess and not interested in pushing traffic there
					Text("Twitter: @\(shop.twitter)")
					Text("FourSquare: \(shop.foursquare)")
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
	let string: String
	var body: some View {
		Image(systemName: "doc.on.doc")
			.padding(.vertical,10)
			.padding(.horizontal,7)
			.background(Color.gray.opacity(0.2))
			.mask(RoundedRectangle(cornerRadius: 3.0))
			.onTapGesture {
				UIPasteboard.general.string = self.string
		}
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
			Image(systemName: "map")
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
		formatted += "+1 ("
		formatted += phone[0..<3]
		formatted += ") "
		formatted += phone[3..<6]
		formatted += "-"
		formatted += phone[6..<10]
		
		return formatted
	}
	var body: some View {
		HStack {
			HStack {
				Image(systemName: "phone")
				if phone != "" && phone != "unknown" {
					HStack {
						Text(phoneFormatted)
						ActionIndicator()
					}
					.onTapGesture {
						callPhoneNumber(number: self.phone)
					}
				} else {
					Text("No phone number set").italic()
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
				Image(systemName: "envelope")
				Text(email)
				ActionIndicator()
			}
			.onTapGesture {
				sendEmail(addr: self.email)
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
			Text(sched)
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


