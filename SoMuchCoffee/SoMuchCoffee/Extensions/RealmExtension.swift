//
//  RealmExtension.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 6/13/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import Foundation
import RealmSwift
import MapKit

//extension RealmCollection where Element: Shop {
extension Collection where Element: Shop {
	
	var centerCoordinate: CLLocationCoordinate2D {
		let lats = self.map{$0.latitude}
		let latmid = (lats.min()! + lats.max()!) / 2

		let lngs = self.map{$0.longitude}
		let lngmid = (lngs.min()! + lngs.max()!) / 2

		return CLLocationCoordinate2D(latitude: latmid, longitude: lngmid)
	}
	
	var latitudeDelta: Double {
		let lats = self.map{$0.latitude}
		let min = lats.min()!
		let max = lats.max()!
		let delta = abs(max - min) // this works in Northern and Southern Hemisphere
		return delta
	}
	
	var longitudeDelta: Double {
		let lngs = self.map{$0.longitude}
		let min = lngs.min()!
		let max = lngs.max()!
		let delta = abs(max - min) // Hopefully no roasters own shops across the international date line. Software issues are mentioned specifically at https://en.wikipedia.org/wiki/180th_meridian
		
		return delta
	}
	
}
