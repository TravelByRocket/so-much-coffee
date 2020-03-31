//
//  Shop.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/24/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI
import CoreLocation

struct Shop : Identifiable, Codable, Comparable {
	var id: String
    var name: String
	var address: String
	var latitudeRaw: String
	var latitude: Double { Double(latitudeRaw) ?? 0 }
	var longitudeRaw: String
	var longitude: Double { Double(longitudeRaw) ?? 0 }
	var roasters: String = "" // probably better as [String]? or [String?]
	var phone: String = ""
	var instagram: String = ""
	var website: String = ""
	var twitter: String = ""
	var foursquare: String = ""
	var yelp: String = ""
	var email: String = ""
	var hours: String = ""
	var stayAtHomeOrderNote = ""
	var beverages = ""
	var food = ""
	var wifi = ""
	var power = ""
	var socializing = ""
	var working = ""
	var summary = ""
	var roastsOwnRaw = ""
	var roastsOwn: Bool? {
		switch roastsOwnRaw {
		case "yes":
			return true
		case "no":
			return false
		default:
			return nil
		}
	}
	var events = ""
	
	init(shop: Shop) {
		self.id = shop.id
		self.name = shop.name
		self.address = shop.address
		self.latitudeRaw = shop.latitudeRaw
		self.longitudeRaw = shop.longitudeRaw
	}
	
	init(id: String, name: String, address: String, latitude: Double, longitude: Double, events: String = "") {
		self.id = id
		self.name = name
		self.address = address
		self.latitudeRaw = String(latitude)
		self.longitudeRaw = String(longitude)
		self.events = events
	}
	
	static func < (lhs: Shop, rhs: Shop) -> Bool {
		return lhs.name < rhs.name
	}
	
	static func == (lhs: Shop, rhs: Shop) -> Bool {
		return lhs.name == rhs.name
	}
	
	var latlon: CLLocationCoordinate2D {
		let lat = CLLocationDegrees(latitude)
		let lon = CLLocationDegrees(longitude)
		let coord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
		return coord
	}
	
	func kilometersAway(from point:CLLocationCoordinate2D) -> Float {
		let locationInput: CLLocation = CLLocation(latitude: point.latitude, longitude: point.longitude)
		let locationShop: CLLocation = CLLocation(latitude: self.latitude, longitude: self.longitude)
		let distanceInMeters = locationShop.distance(from: locationInput)
		return Float(distanceInMeters)/1000
	}
}
