//
//  Roasters.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/29/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

class Roasters: ObservableObject {
	let items: [Roaster]
	
	init() {
		// https://www.npmjs.com/package/csvtojson
		// npm i -g csvtojson
		// csvtojson shops.csv > shops.json
		// only issue is that lat/lon surrounded by quotes so for now manually adjusting JSON to fit the Float/Double formatting that is has now
//		self.items = Bundle.main.decode([Roaster].self, from: "roasters.json")
		self.items = []
	}
	
	init(roasters: [Roaster]) {
		self.items = roasters
	}
	
	func roasterNameFromID (_ roasterID: String) -> String {
		if let match = items.first(where: {$0.id == roasterID} ) {
			return match.name
		} else {
			return "id \"\(roasterID)\" not found"
		}
	}
	
	func roasterFromID (_ roasterID: String) -> Roaster {
		if let match = items.first(where: {$0.id == roasterID} ) {
			return match
		} else {
			return Roaster.blankRoaster()
		}
	}
	
	static func load () -> Roasters {
		Roasters(roasters: Bundle.main.decode([Roaster].self, from: "roasters.json"))
	}
}
