//
//  Coffee.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/1/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct CoffeeJSON: Decodable, Hashable, Comparable {
//	var id = UUID() // breaks decodable and would be easier to just use \.self for List at this point
	var name: String
	var originID: String
	var roasterID: String
	var url: String
	
	static func < (lhs: CoffeeJSON, rhs: CoffeeJSON) -> Bool {
		return lhs.name < rhs.name
	}
	
	static func == (lhs: CoffeeJSON, rhs: CoffeeJSON) -> Bool {
		// return lhs.hashValue == rhs.hashValue
		return lhs.name == rhs.name
	}
}
