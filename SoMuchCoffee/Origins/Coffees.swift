//
//  Coffees.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/1/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct Coffees {
	let items: [Coffee]
	
	static var everyFromJSON: [Coffee] {
		Bundle.main.decode([Coffee].self, from: "coffees.json")
	}
	
	static var oneFromJSON: Coffee {
		let count = everyFromJSON.count
		let index = Int.random(in: 0..<count)
		return everyFromJSON[index]
	}
	
	static var all: Coffees {
		Coffees(items: everyFromJSON)
	}
	
}
