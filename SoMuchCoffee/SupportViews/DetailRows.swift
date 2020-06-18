//
//  DetailRows.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 6/16/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI
import RealmSwift
import FontAwesome_swift

struct DetailRow<T: Object>: View where T: Reportable{
	var style: DetailType
	var value: String?
	var entity: T
	
	var body: some View {
		
		switch style {
		case .correction:
			return AnyView ( EmailCorrectionRow(style: .correction, entity: entity) )
		case .website, .eventsURL, .instagram, .productURL, .orderURL, .subscribeURL, .wikiURL, .atlasURL, .cafeImportURL, .otherURL1, .otherURL2:
			return AnyView ( StandardURL(style: style, value: value, entity: entity) )
		case .phone, .email:
			return AnyView ( ActionURL(style: style, value: value, entity: entity) )
		default:
			return AnyView ( CommonDetailRow(style: style, value: value, entity: entity) )
		}
	}
}

enum DetailType: String { // the raw values are used to describe what information is missing on a page
	case address = "address"
	case phone = "phone"
	case instagram = "Instagram"
	case website = "website"
	case email = "email"
	case hours = "hours"
	case stayAtHomeOrderNote = "COVID"
	case beveragesNote = "beverages"
	case foodNote = "food"
	case wifiNote = "WiFi"
	case powerOutlets = "power outlets"
	case atmosphereSocial = "socializing"
	case atmosphereWork = "working/studying"
	case eventsURL = "events"
	case correction = "correction"
	case offerDetails = "discount"
	case offerCode = "discount code"
	case orderURL = "online ordering"
	case subscribeURL = "coffee subscription"
	case productURL = "online product"
	case wikiURL
	case atlasURL
	case cafeImportURL
	case otherURL1
	case otherURL2

	
	var icon: AnyView {
		switch self {
		case .address:
			return AnyView ( Image(systemName: "map.fill") )
		case .phone:
			return AnyView ( Image(systemName: "phone.fill") )
		case .instagram:
			return AnyView ( FontAwesomeIcon(name: .instagram, type: .brands) )
		case .website, .orderURL, .subscribeURL, .productURL, .wikiURL, .atlasURL, .cafeImportURL, .otherURL1, .otherURL2:
			return AnyView ( FontAwesomeIcon(name: .globe, type: .solid) )
		case .email:
			return AnyView ( Image(systemName: "at") )
		case .hours:
			return AnyView ( Image(systemName: "clock.fill") )
		case .stayAtHomeOrderNote:
			return AnyView ( Image(systemName: "message.fill") )
		case .beveragesNote:
			return AnyView ( FontAwesomeIcon(name: .glassWhiskey, type: .solid) )
		case .foodNote:
			return AnyView ( FontAwesomeIcon(name: .utensils, type: .solid) )
		case .wifiNote:
			return AnyView ( FontAwesomeIcon(name: .wifi, type: .solid) )
		case .powerOutlets:
			return AnyView ( FontAwesomeIcon(name: .plug, type: .solid) )
		case .atmosphereSocial:
			return AnyView ( FontAwesomeIcon(name: .userFriends, type: .solid) )
		case .atmosphereWork:
			return AnyView ( FontAwesomeIcon(name: .book, type: .solid) )
		case .eventsURL:
			return AnyView ( FontAwesomeIcon(name: .calendarCheck, type: .regular) )
		case .correction:
			return AnyView ( Image(systemName: "exclamationmark.square.fill") )
		case .offerDetails:
			return AnyView ( Image(systemName: "dollarsign.square.fill") )
		case .offerCode:
			return AnyView ( Image(systemName: "barcode") )
			
		}
		
	}
	
	var actionable: Bool { // shows action symbol
		switch self {
		case .instagram, .website, .eventsURL, .phone, .email, .orderURL, .subscribeURL, .productURL, .wikiURL, .atlasURL, .cafeImportURL, .otherURL1, .otherURL2:
			return true
		default:
			return false
		}
	}
	
	var copyable: Bool { // shows copy-to-clipboard view
		switch self {
		case .address, .email:
			return true
		default:
			return false
		}
	}
}

struct NameTitle: View {
	let name: String
	var body: some View {
		Text(self.name).font(.title).multilineTextAlignment(.center).padding(.horizontal)
	}
}

struct SummaryBlock: View {
	let summary: String?
	var body: some View {
		Text(summary ?? "No summary yet").multilineTextAlignment(.leading).padding(.horizontal)
	}
}

struct CommonDetailRow<T: Object>: View where T: Reportable {
	var style: DetailType
	var value: String?
	var entity: T
	
	@State private var showSheet = false
	
	var body: some View {
		
		HStack {
			style.icon
			if (value != nil) {
				AnyView(
					HStack {
						if (!style.actionable) {
							Text(value!).frame(maxWidth: .infinity)
						} else if (style == .email) {
							Text(value!).frame(maxWidth: .infinity)
								.onTapGesture { sendEmail(addr: self.value!) }
						} else if (style == .phone) {
							Text(value!).frame(maxWidth: .infinity)
								.onTapGesture { callPhoneNumber(number: self.value!) }
						}  else if (style == .instagram) {
						   Text(value!).frame(maxWidth: .infinity)
							.onTapGesture { self.showSheet = true }
							   .sheet(isPresented: $showSheet, content: { SafariView(url: URL(string: "https://instagram.com/\(self.value!)")!) } )
					   } else {
							Text(value!).frame(maxWidth: .infinity)
								.onTapGesture { self.showSheet = true }
								.sheet(isPresented: $showSheet, content: { SafariView(url: URL(string: self.value!)!) } )
						}
						
						if (style.actionable) {ActionIndicator()}
						if (style.copyable) {CopyFieldToClipboard(string: value)}
					}
				)
			} else {
				AnyView ( NotAvailable(style: style, entity: entity) )
			}
		}.frame(alignment: .leading)
	}
}

struct ActionURL<T: Object>: View where T: Reportable {
	var style: DetailType
	var value: String?
	var entity: T
	
	var body: some View {
		if (value != nil) {
			return AnyView (
				HStack {
					style.icon
					Text(self.value!).onTapGesture { self.useURL() }
				}
			)
		} else {
			return AnyView (
				HStack {
					style.icon
					NotAvailable(style: style, entity: entity)
				}
			)
		}
	}
	
	func useURL() {
		if (style == .phone) { callPhoneNumber(number: self.value!) }
		else if (style == .email) { sendEmail(addr: self.value!) }
	}
}

struct StandardURL<T: Object>: View where T: Reportable {
	var style: DetailType
	var value: String?
	var entity: T
	
	var label: String? {
		switch style {
		case .instagram:
			return "@\(value!)"
		case .website:
			return "Visit Website"
		case .orderURL:
			return "Order Beans Online"
		case .subscribeURL:
			return "Coffee Subscription Page"
		case .productURL:
			return "Order \(entity.name) Online"
		case .wikiURL:
			return "Wikipedia"
		case .atlasURL:
			return "Atlas Coffee Importers"
		case .cafeImportURL:
			return "Cafe Imports"
		case .otherURL1, .otherURL2:
			return "Other URL ... \(value ?? "")"
		default:
			return value
		}
	}
	
	@State var showSheet = false
	
	var body: some View {
		if (value != nil) {
			return AnyView (
				HStack {
					style.icon
					Text(self.label!)
						.onTapGesture { self.showSheet = true }
						.sheet(isPresented: $showSheet, content: { SafariView(url: URL(string: self.value!)!) } )
				}
			)
		} else {
			return AnyView (
				HStack {
					style.icon
					NotAvailable(style: style, entity: entity)
				}
			)
		}
		
	}
}

struct NotAvailable<T: Object>: View where T: Reportable {
	var style: DetailType
	var entity: T
	
	var body: some View {
		Text("No \(self.style.rawValue) info available. Tap to provide details.")
			.italic()
			.foregroundColor(Color.secondary)
			.onTapGesture {
				sendEmail(addr: preformattedMAILTO(style: self.style, entity: self.entity))
		}
	}
}

func preformattedMAILTO<T: Object>(style: DetailType, entity: T) -> String where T: Reportable {
	// TODO switch to MessageUI for more control over how to send email corrections
	// Cannot use entity.name because strings are not converted for MAILTO compatibility
	// ... but `entity.id` and `style` use only [A-Za-z] so naturally usable
	// https://www.hackingwithswift.com/example-code/uikit/how-to-send-an-email
	// https://developer.apple.com/documentation/messageui/mfmailcomposeviewcontroller
	// https://stackoverflow.com/questions/45154606/why-am-i-getting-unresolved-identifier-when-using-mfmailcomposeviewcontroller
	// https://www.hackingwithswift.com/books/ios-swiftui/wrapping-a-uiviewcontroller-in-a-swiftui-view
	// https://www.andrewcbancroft.com/2014/08/25/send-email-in-app-using-mfmailcomposeviewcontroller-with-swift/
	
	// Multi-line string would work when running full app but was supposed cause of failure to build for previews here. Another reason to switch to MessageUI.
	let emailTextCoded = "app@somuchcoffee.co?subject=Correction%20for%20\(String(describing: type( of: entity)))&body=%0D%0A%0D%0A%0D%0A\(String(describing: type( of: entity)))%3A%20\(entity.id)%0D%0AField%3A%20\(style)"
	
	return emailTextCoded
}

struct CopyFieldToClipboard: View {
	// view disables itself if string = ni
	// it is actually not displayed based on earlier logic as of June 17, 2020
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
//		Image(systemName: "projective")
//		Image(systemName: "chevron.up.circle")
		Image(systemName: "chevron.right.circle")
	}
}

struct EmailCorrectionRow<T: Object>: View where T: Reportable {
	var style: DetailType
	var entity: T
	
	var body: some View {
		HStack {
			style.icon
			Text("Correction? Send us an email!")
				.italic().frame(maxWidth: .infinity)
			ActionIndicator()
		}
		.foregroundColor(Color.orange)
		.onTapGesture {
			sendEmail(addr: preformattedMAILTO(style: self.style, entity: self.entity))
		}
	}
}

struct EmailCorrectionRowAgnostic: View {
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
		UIApplication.shared.open(url) // only iOS 10+ but my my SwiftUI target is already 13+
	}
}

func sendEmail(addr: String) {
	if let url = URL(string: "mailto:\(addr)"), UIApplication.shared.canOpenURL(url) {
		UIApplication.shared.open(url) // only iOS 10+ but my my SwiftUI target is already 13+
	}
}


struct DetailRows_Previews: PreviewProvider {
	static let shop: Shop = realm.objects(Shop.self).randomElement()!
    static var previews: some View {
		VStack {
			NameTitle(name: shop.name)
			SummaryBlock(summary: shop.summary)
			List {
				Section (header: Text("A Section of Stuff")) {
					DetailRow(style: .instagram, value: shop.instagram, entity: shop)
					DetailRow(style: .phone, value: shop.phone, entity: shop)
				}
			}
		}
    }
}
