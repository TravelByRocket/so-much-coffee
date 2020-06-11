//
//  Coffees.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/1/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct Coffees {
	let items: [CoffeeJSON]
	
	static var everyFromJSON: [CoffeeJSON] {
		Bundle.main.decode([CoffeeJSON].self, from: "coffees.json")
	}
	
	static var oneFromJSON: CoffeeJSON {
		let count = everyFromJSON.count
		let index = Int.random(in: 0..<count)
		return everyFromJSON[index]
	}
	
	static var all: Coffees {
		Coffees(items: everyFromJSON)
	}
	
}
