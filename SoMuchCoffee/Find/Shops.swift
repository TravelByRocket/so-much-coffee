//
//  Shops.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/21/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI
import MapKit

class Shops: ObservableObject {
	@Published var allWithinMapAreaSorted: [ShopWithDistance] = []
	let items: [Shop]
	
	init() {
		self.items = Bundle.main.decode([Shop].self, from: "shops.json")
	}
	
	init(oneShop: Shop) {
		self.items = [oneShop]
	}
	
	struct ShopWithDistance: Comparable {
		let shop: Shop
		let distance: Float
		
		init(shop: Shop, point: CLLocationCoordinate2D) {
			self.shop = shop
			self.distance = shop.kilometersAway(from: point)
		}
		
		static func == (lhs: ShopWithDistance, rhs: ShopWithDistance) -> Bool {
			return lhs.distance == rhs.distance
		}
		
		static func < (lhs: ShopWithDistance, rhs: ShopWithDistance) -> Bool {
			return lhs.distance < rhs.distance
		}
		
	}
	
	
	
	func updateShopsInMapAreaSorted(within area: MKMapRect, distanceTo point: CLLocationCoordinate2D) {
		var shopsWithDistance: [ShopWithDistance] = []
		for shop in items {
			if area.contains(MKMapPoint(shop.latlon)) {
				shopsWithDistance.append(ShopWithDistance(shop: shop, point: point))
			}
		}
		allWithinMapAreaSorted = shopsWithDistance.sorted()
//		allWithinMapAreaSorted = shopsWithDistance.sorted().map { $0.shop }
	}
}
