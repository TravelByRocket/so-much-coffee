//
//  Countries.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/2/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct Origins {
	let items: [Origin]
	
	var regionNames: [String] {
		let set = Set(items.map { $0.regionName })
		let arr = set.sorted()
		return arr
	}
		
	static var everyFromJSON: [Origin] {
		Bundle.main.decode([Origin].self, from: "origins.json")
	}
	
	static var all: Origins {
		Origins(items: everyFromJSON)
	}
	
	static var oneFromJSON: Origin {
		let count = everyFromJSON.count
		let index = Int.random(in: 0..<count)
		return everyFromJSON[index]
	}
	
	func originFromID (_ countryID: String) -> Origin {
		if let match = items.first(where: {$0.id == countryID} ) {
			return match
		} else {
			return Origin.placeholder(countryID)
		}
	}
	
}
