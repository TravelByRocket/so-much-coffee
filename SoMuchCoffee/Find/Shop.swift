//
//  Shop.swift
//  RealmStarter
//
//  Created by Bryan Costanza on 6/8/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import Foundation
import RealmSwift

class Shop : Object, Identifiable { // identifiable is not used in this processing app but would be used when I bring this class definition back to the main app
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
}
