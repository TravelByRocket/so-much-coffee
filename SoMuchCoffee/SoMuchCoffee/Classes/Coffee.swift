//
//  Coffee.swift
//  RealmStarter
//
//  Created by Bryan Costanza on 6/8/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import Foundation
import RealmSwift

class Coffee : Object, Identifiable, Reportable {
    @objc dynamic var uuid: String = UUID().uuidString // I want some id but no need to id each by hand like a Shop
    @objc dynamic var name: String = "" // should not be blank but must have a default value and seems innapropriate for optional, as in it would be silly to add logic to my app for an optional when it should not be happening
    let origins = List<Origin>() // this would not need to be a list for single-origin but I think I'll keep it for future compatibility since it doesn't lose meaning or impede usefulness very much; non-zero chance of putting espresso blends, for example, into the directory
    @objc dynamic var roaster: Roaster? // objects must be optional; no placeholder Roaster anyway, nor a way to use one
    @objc dynamic var url: String? // it might not be available online
    
	var id: String {uuid} // enable Identifiable
	
    // TASTING NOTES or FLAVORS
    // SUMMARY from website?
    // ACTIVE or AVAILABLE or INSTOCK or delete old ones?
    // SHOPSSERVING
    
    override var description: String { return "Coffee: \(name)" }
    override static func primaryKey() -> String? { return "uuid" }
}
