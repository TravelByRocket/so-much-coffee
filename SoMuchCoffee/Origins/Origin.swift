//
//  Country.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/2/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct Origin: Decodable, Hashable, Comparable {
	let id: String
	let name: String
	let regionName: String
	let wikiURL: String = ""
	let atlasURL: String = ""
	let cafeImportURL: String = ""
	let otherURL1: String = ""
	let otherURL2: String = ""
	
	static func < (lhs: Origin, rhs: Origin) -> Bool {
		return lhs.name < rhs.name
	}
	
	static func == (lhs: Origin, rhs: Origin) -> Bool {
		// return lhs.hashValue == rhs.hashValue
		return lhs.name == rhs.name
	}
	
	static func placeholder (_ info: String) -> Origin {
		Origin(id: "??? \(info)", name: "??? \(info)", regionName: "??? \(info)")
	}
}
