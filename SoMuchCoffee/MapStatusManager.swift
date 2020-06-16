//
//  MapStatusManager.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/5/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

class MapStatusManager: ObservableObject {
	var centerCoordinate: CLLocationCoordinate2D? {
		get { return centerCoordinateCur }
		set {
			centerCoordinatePrev = centerCoordinateCur
			centerCoordinateCur = newValue
//			print("msm MapStatusManager.centerCoordinateCur is now \(String(describing: self.centerCoordinateCur)) at \(Date())")
		}
	}

	var longitudeSpan: Double? {
		get { return longitudeSpanCur }
		set {
			longitudeSpanPrev = longitudeSpanCur
			longitudeSpanCur = newValue
//			print("msm MapStatusManager.longitudeSpanCur is now \(String(describing: self.longitudeSpanCur)) at \(Date())")
		}
	}
	
//	@Published var visibleMapRect: MKMapRect?
	
//	var centerCoordinate: CLLocationCoordinate2D?
//	var longitudeSpan: Double?
	
	private var centerCoordinateCur: CLLocationCoordinate2D?
	private var longitudeSpanCur: Double?

	private var centerCoordinatePrev: CLLocationCoordinate2D?
	private var longitudeSpanPrev: Double?
	
	@Published var centerCoordinateFixed: CLLocationCoordinate2D?
	@Published var longitudeSpanFixed: Double?
	
	var allowUpdating: Bool = false
	
	init() {
		self.centerCoordinateCur = nil
		self.centerCoordinatePrev = nil
		self.longitudeSpanCur = nil
		self.longitudeSpanPrev = nil
		
//		self.centerCoordinate = nil
//		self.longitudeSpan = nil
		
		self.centerCoordinateFixed = nil
		self.longitudeSpanFixed = nil
	}
	
	func reset() {
		self.centerCoordinateCur = nil
		self.centerCoordinatePrev = nil
		self.longitudeSpanCur = nil
		self.longitudeSpanPrev = nil
		
//		self.centerCoordinate = nil
//		self.longitudeSpan = nil
		
		self.centerCoordinateFixed = nil
		self.longitudeSpanFixed = nil
	}
	
	
	
	func update() {
		if centerCoordinateCur != nil && centerCoordinatePrev != nil {
			self.centerCoordinateFixed = centerCoordinatePrev
			self.longitudeSpanFixed = longitudeSpanPrev
			
//			self.centerCoordinateFixed = centerCoordinate
//			self.longitudeSpanFixed = longitudeSpan

			self.centerCoordinateCur = nil
			self.centerCoordinatePrev = nil
			self.longitudeSpanCur = nil
			self.longitudeSpanPrev = nil
		}
	}
	
	
}
