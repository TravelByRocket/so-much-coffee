//
//  Coffee.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/1/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct Coffee: Codable, Hashable, Comparable {
	var name: String
	var originID: String
	var roasterID: String
	var url: String
	
	static func < (lhs: Coffee, rhs: Coffee) -> Bool {
		return lhs.name < rhs.name
	}
	
	static func == (lhs: Coffee, rhs: Coffee) -> Bool {
		// return lhs.hashValue == rhs.hashValue
		return lhs.name == rhs.name
	}
	
	static var example: Coffee {
		Coffee(name: "Generic Roast", originID: "ecuador", roasterID: "sweetbloom", url: "http://somuchcoffee.co")
	}
}
