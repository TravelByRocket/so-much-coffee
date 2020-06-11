//
//  Roaster.swift
//  RealmStarter
//
//  Created by Bryan Costanza on 6/8/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import Foundation
import RealmSwift

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
    
    override var description: String { return "Roaster: \(name)"}
    override static func primaryKey() -> String? {return "id"}
}
