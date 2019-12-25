//
//  Shop.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/24/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI
import MapKit

struct Shop : Identifiable {
    var id = UUID()
    var name: String
	let location: CLLocationCoordinate2D
}

#if DEBUG
let testShops = [
	Shop(name: "Little Owl", location: .init(latitude: 39.754450, longitude: -104.996856)),
	Shop(name: "Mercantile", location: .init(latitude: 39.764450, longitude: -104.986856)),
	Shop(name: "Denver Bicycle Cafe", location: .init(latitude: 39.774450, longitude: -104.976856)),
	Shop(name: "Weathervane", location: .init(latitude: 39.784450, longitude: -104.966856)),
	Shop(name: "Huckleberry", location: .init(latitude: 39.794450, longitude: -104.956856))
]

#endif

