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
	
	private var latitudes: [Double] { items.map { $0.latitude } }
	private var longitudes: [Double] { items.map { $0.longitude } }
	
	private var minLatitude: Double { latitudes.min()! }
	private var maxLatitude: Double { latitudes.max()! }
	private var midLatitude: Double { (maxLatitude + minLatitude) / 2 }
	
	private var minLongitude: Double { longitudes.min()! }
	private var maxLongitude: Double { longitudes.max()! }
	private var midLongitude: Double { (maxLongitude + minLongitude) / 2 }
	
	private let bufferFactor = 1.2
	
	var centerOfShops: CLLocationCoordinate2D {
		return CLLocationCoordinate2D(latitude: midLatitude, longitude: midLongitude)
	}
	
	var latitudeDeltaOfShops: Double {
		let minDelta = 0.015
		let latDelta = maxLatitude - minLatitude
		let latDeltaChecked = max(latDelta,minDelta)
		return latDeltaChecked * bufferFactor
	}
	var longitudeDeltaOfShops: Double {
		let minDelta = 0.015
		let lonDelta = maxLongitude - minLongitude
		let lonDeltaChecked = max(lonDelta,minDelta)
		return lonDeltaChecked * bufferFactor
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
