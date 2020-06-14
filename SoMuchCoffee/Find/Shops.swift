//
//  Shops.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/21/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

//import SwiftUI
//import MapKit
//
//class Shops: ObservableObject {
//	@Published var allWithinMapAreaSorted: [ShopWithDistance] = []
//	let items: [ShopJSON]
//	
//	struct ShopWithDistance: Comparable {
//		let shop: ShopJSON
//		let distance: Float
//		
//		init(shop: ShopJSON, point: CLLocationCoordinate2D) {
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
//	func updateShopsInMapAreaSorted(within area: MKMapRect, distanceTo point: CLLocationCoordinate2D) {
//		var shopsWithDistance: [ShopWithDistance] = []
//		for shop in items {
//			if area.contains(MKMapPoint(shop.latlon)) {
//				shopsWithDistance.append(ShopWithDistance(shop: shop, point: point))
//			}
//		}
//		allWithinMapAreaSorted = shopsWithDistance.sorted()
//	}
//	
//	func shopCountToCircleStringName(_ roasterID: String) -> String {
//		let count = shopsServing(roasterID: roasterID).count
//		if count <= 50 {
//			return String(count) + ".circle"
//		} else {
//			return "asterisk.circle"
//		}
//	}
//}
