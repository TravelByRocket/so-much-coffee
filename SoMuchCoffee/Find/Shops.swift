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
	
	var latitudes: [Double] { items.map { $0.latitude } }
	var longitudes: [Double] { items.map { $0.longitude } }
	
	var minLatitude: Double { latitudes.min()! }
	var maxLatitude: Double { latitudes.max()! }
	var midLatitude: Double { (maxLatitude + minLatitude) / 2 }
	
	var minLongitude: Double { longitudes.min()! }
	var maxLongitude: Double { longitudes.max()! }
	var midLongitude: Double { (maxLongitude + minLongitude) / 2 }
	
	var centerOfShops: CLLocationCoordinate2D {
		return CLLocationCoordinate2D(latitude: midLatitude, longitude: midLongitude)
	}
	
	var latlonDeltaOfShops: Double {
		let latlonBuffer = 1.1 // Needs about 1.4 if not ignoring top safe area
		let minDelta = 0.015
		let latDelta = maxLatitude - minLatitude
		let lonDelta = maxLongitude - minLongitude
		let latlonDelta = max(latDelta,lonDelta,minDelta)
		return latlonDelta * latlonBuffer
	}
	
	init() {
		// https://www.npmjs.com/package/csvtojson
		// npm i -g csvtojson
		// csvtojson shops.csv > shops.json
		// only issue is that lat/lon surrounded by quotes so for now manually adjusting JSON to fit the Float/Double formatting that is has now
		self.items = Bundle.main.decode([Shop].self, from: "shops.json")
	}
	
	init(oneShop: Shop) {
		self.items = [oneShop]
	}
	
	init(shops: [Shop]) {
		self.items = shops
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
	}
	
	func shopsServing(roasterID: String) -> [Shop] {
		var matchingShops = [Shop]()
		for shop in items {
			for id in shop.roasters.components(separatedBy: ",") {
				if roasterID == id { // could make this a `where` in enclosing `for`
					matchingShops.append(shop)
				}
			}
		}
		return matchingShops
	}
	
}
