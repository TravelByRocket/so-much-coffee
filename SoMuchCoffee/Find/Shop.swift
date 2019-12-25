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
	Shop(name: "Little Owl Coffee", location: .init(latitude: 39.750535, longitude: -104.999658)),
	Shop(name: "Mercantile Dining & Provision", location: .init(latitude: 39.753630, longitude: -104.999705)),
	Shop(name: "Precision Pours", location: .init(latitude: 39.986922, longitude: -105.131426)),
	Shop(name: "The Weathervane Cafe", location: .init(latitude: 39.743460, longitude: -104.966524)),
	Shop(name: "Huckleberry Roasters (Milk Market)", location: .init(latitude: 39.753550, longitude: -104.996746))
]

#endif

