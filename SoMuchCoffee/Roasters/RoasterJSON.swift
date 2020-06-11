//
//  Roaster.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/29/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RoasterJSON : Identifiable, Codable, Comparable {
	var id: String
    var name: String
	var description: String = ""
	var instagram: String = ""
	var fairtrade: String = ""
	var code: String = ""
	var offer: String = ""
	var ordering: String = ""
	var subscription: String = ""
	var locationShort: String = ""
	
	static func blankRoaster() -> RoasterJSON {
		return RoasterJSON(id: "notfound", name: "Roaster Not Found", description: "Please report this error")
	}
	
	static func < (lhs: RoasterJSON, rhs: RoasterJSON) -> Bool {
		return lhs.name < rhs.name
	}
	
	static func == (lhs: RoasterJSON, rhs: RoasterJSON) -> Bool {
		return lhs.name == rhs.name
	}

}
