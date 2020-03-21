//
//  Shop.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/24/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI
import CoreLocation

struct Shop : Identifiable, Codable {
	var id: String
    var name: String
	var address: String
	var latitude: Double
	var longitude: Double
	
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
