//
//  Roasters.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/29/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

class Roasters: ObservableObject {
//	@Published var allWithinMapAreaSorted: [ShopWithDistance] = []
	let items: [Roaster]
	
	init() {
		// https://www.npmjs.com/package/csvtojson
		// npm i -g csvtojson
		// csvtojson shops.csv > shops.json
		// only issue is that lat/lon surrounded by quotes so for now manually adjusting JSON to fit the Float/Double formatting that is has now
		self.items = Bundle.main.decode([Roaster].self, from: "roasters.json")
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
	
//	init(oneShop: Shop) {
//		self.items = [oneShop]
//	}
	
//	struct ShopWithDistance: Comparable {
//		let shop: Shop
//		let distance: Float
//		
//		init(shop: Shop, point: CLLocationCoordinate2D) {
//			self.shop = shop
//			self.distance = shop.kilometersAway(from: point)
//		}
//		
//		static func == (lhs: ShopWithDistance, rhs: ShopWithDistance) -> Bool {
//			return lhs.distance == rhs.distance
//		}
//		
//		static func < (lhs: ShopWithDistance, rhs: ShopWithDistance) -> Bool {
//			return lhs.distance < rhs.distance
//		}
//		
//	}
//	
//	
//	
//	func updateShopsInMapAreaSorted(within area: MKMapRect, distanceTo point: CLLocationCoordinate2D) {
//		var shopsWithDistance: [ShopWithDistance] = []
//		for shop in items {
//			if area.contains(MKMapPoint(shop.latlon)) {
//				shopsWithDistance.append(ShopWithDistance(shop: shop, point: point))
//			}
//		}
//		allWithinMapAreaSorted = shopsWithDistance.sorted()
////		allWithinMapAreaSorted = shopsWithDistance.sorted().map { $0.shop }
//	}
}
