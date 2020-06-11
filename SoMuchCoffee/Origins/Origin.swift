//
//  Origin.swift
//  RealmStarter
//
//  Created by Bryan Costanza on 6/8/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import Foundation
import RealmSwift

class Origin : Object, Identifiable {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    private dynamic var privateRawRegion: String = Region.Other.rawValue
    var region: Region {
        // enum example from https://medium.com/it-works-locally/persisting-swift-enumerations-with-realm-io-dab37cd98bcd
        // enum pattern from https://stackoverflow.com/questions/37997766/enums-support-with-realm
        get { return Region(rawValue: privateRawRegion)! }
        set { privateRawRegion = newValue.rawValue }
    }
    @objc dynamic var wikiURL: String?
    @objc dynamic var atlasURL: String?
    @objc dynamic var cafeImportURL: String?
    @objc dynamic var otherURL1: String?
    @objc dynamic var otherURL2: String?
    
    // INDICATIVE FLAVORS
    
    override var description: String { return "Origin: \(name)"}
    override static func primaryKey() -> String? {return "id"}
    
    public enum Region: String {
        case NorthAmerica = "North America"
        case CentralAmerica = "Central America"
        case SouthAmerica = "South America"
        case AfricaAndMiddleEast = "Africa & Middle East"
        case AsiaPacific = "Asia-Pacific"
        case Other = "Other" // not expected to use but serves as default value to support enum use
    }
    
}
