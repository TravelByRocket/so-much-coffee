//
//  Shop.swift
//  RealmStarter
//
//  Created by Bryan Costanza on 6/8/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import Foundation
import RealmSwift
import MapKit

class Shop : Object, Identifiable, Reportable {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    let roasters = List<Roaster>()
    @objc dynamic var affiliatedRoaster: Roaster?
    @objc dynamic var address: String = ""
    @objc dynamic var latitude: Double = 0
    @objc dynamic var longitude: Double = 0
    @objc dynamic var phone: String?
    @objc dynamic var instagram: String?
    @objc dynamic var website: String?
    @objc dynamic var twitter: String?
    @objc dynamic var foursquare: String?
    @objc dynamic var yelp: String?
    @objc dynamic var email: String?
    @objc dynamic var hours: String?
    @objc dynamic var stayAtHomeOrderNote: String?
    @objc dynamic var beveragesNote: String?
    @objc dynamic var foodNote: String?
    @objc dynamic var wifiNote: String?
    @objc dynamic var powerOutlets: String?
    @objc dynamic var atmosphereSocial: String?
    @objc dynamic var atmosphereWork: String?
    @objc dynamic var summary: String?
    @objc dynamic var eventsURL: String?
    
    override var description: String { return "Shop: \(name)"}
    override static func primaryKey() -> String? {return "id"}
	
	var latlon: CLLocationCoordinate2D {
		let lat = CLLocationDegrees(latitude)
		let lon = CLLocationDegrees(longitude)
		let coord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
		return coord
	}

	func kilometersAway(from referencePoint: CLLocationCoordinate2D?) -> Double { // not truly optional but I would rather do nil handling here for now
		let mapCenter = CLLocation(latitude: referencePoint?.latitude ?? 40, longitude: referencePoint?.longitude ?? -105)
		let shopPosition = CLLocation(latitude: self.latitude, longitude: self.longitude)
		return mapCenter.distance(from: shopPosition) / 1000
	}
	
	static var visibleMapRect: MKMapRect?
	
	var isInMapRect: Bool {
		Shop.visibleMapRect?.contains(MKMapPoint(CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude))) ?? true
	}
}
