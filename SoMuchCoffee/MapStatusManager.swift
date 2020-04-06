//
//  MapStatusManager.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/5/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI
import CoreLocation

class MapStatusManager: ObservableObject {
	var centerCoordinate: CLLocationCoordinate2D? {
		get { return centerCoordinateCur }
		set {
			centerCoordinatePrev = centerCoordinateCur
			centerCoordinateCur = newValue
		}
	}
	
	var longitudeSpan: Double? {
		get { return longitudeSpanCur }
		set {
			longitudeSpanPrev = longitudeSpanCur
			longitudeSpanCur = newValue
		}
	}
	
	private var centerCoordinateCur: CLLocationCoordinate2D?
	private var longitudeSpanCur: Double?
	
	private var centerCoordinatePrev: CLLocationCoordinate2D?
	private var longitudeSpanPrev: Double?
	
	@Published var centerCoordinateFixed: CLLocationCoordinate2D?
	@Published var longitudeSpanFixed: Double?
	
	init() {
		self.centerCoordinateCur = nil
		self.centerCoordinatePrev = nil
		self.longitudeSpanCur = nil
		self.longitudeSpanPrev = nil
		
		self.centerCoordinateFixed = nil
		self.longitudeSpanFixed = nil
	}
	
	func reset() {
		self.centerCoordinateCur = nil
		self.centerCoordinatePrev = nil
		self.longitudeSpanCur = nil
		self.longitudeSpanPrev = nil
		
		self.centerCoordinateFixed = nil
		self.longitudeSpanFixed = nil
	}
	
	func update() {
		if centerCoordinateCur != nil && centerCoordinatePrev != nil {
			self.centerCoordinateFixed = centerCoordinatePrev
			self.longitudeSpanFixed = longitudeSpanPrev

			self.centerCoordinateCur = nil
			self.centerCoordinatePrev = nil
			self.longitudeSpanCur = nil
			self.longitudeSpanPrev = nil
		}

		print("msm MapStatusManager.centerCoordinateFixed is now \(self.centerCoordinateFixed)")
//		print("lat centercoordfixed is \(String(describing: self.centerCoordinateFixed?.latitude))")
//		print("lon centercoordfixed is \(String(describing: self.centerCoordinateFixed?.longitude))")
	}
	
	
}
