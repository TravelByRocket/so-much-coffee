//
//  Roaster.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/29/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct Roaster : Identifiable, Codable {
	var id: String
    var name: String
	var description: String = ""
	var instagram: String = ""
	var fairtrade: String = ""
	var code: String = ""
	var offer: String = ""
	var ordering: String = ""
	var subscription: String = ""
	
	static func blankRoaster() -> Roaster {
		return Roaster(id: "notfound", name: "Roaster Not Found", description: "Please report this error")
	}

}
