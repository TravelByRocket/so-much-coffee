//
//  Roaster.swift
//  RealmStarter
//
//  Created by Bryan Costanza on 6/8/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import Foundation
import RealmSwift
import MapKit

class Roaster : Object, Identifiable {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    
    @objc dynamic var summary: String?
    @objc dynamic var instagram: String?
    var isFairtrade = RealmOptional<Bool>()
    @objc dynamic var offerCode: String?
    @objc dynamic var offerDetails: String?
    @objc dynamic var orderingURL: String?
    @objc dynamic var subscriptionURL: String?
    
    let shopsOwned = LinkingObjects(fromType: Shop.self, property: "affiliatedRoaster")
    let shopsServing = LinkingObjects(fromType: Shop.self, property: "roasters")
	
	var shopsServing_centerCoordinate: CLLocationCoordinate2D {
		let lats = shopsServing.map{$0.latitude}
		let latmid = (lats.min()! + lats.max()!) / 2
		
		let lngs = shopsServing.map{$0.longitude}
		let lngmid = (lngs.min()! + lngs.max()!) / 2
		
		return CLLocationCoordinate2D(latitude: latmid, longitude: lngmid)
	}
	
	var shopsServing_latitudeDelta: Double {
		let lats = shopsServing.map{$0.latitude}
		let delta = lats.max()! + lats.min()!
		
		return delta
	}
    
    override var description: String { return "Roaster: \(name)"}
    override static func primaryKey() -> String? {return "id"}
}
