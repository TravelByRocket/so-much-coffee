//
//  LocationManager.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/25/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

// Guidance from https://adrianhall.github.io/swift/2019/11/05/swiftui-location/

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
	private let locationManager = CLLocationManager()
	let objectWillChange = PassthroughSubject<Void, Never>()
	
	@Published var status: CLAuthorizationStatus? {
		willSet { objectWillChange.send() }
	}
	
	@Published var location: CLLocation? {
		willSet { objectWillChange.send() }
	}
	
	override init() {
		super.init()
		
		self.locationManager.delegate = self
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
		self.locationManager.requestWhenInUseAuthorization()
		self.locationManager.startUpdatingLocation()
	}
	
	private func geocode() {
		// For later
	}
}

extension LocationManager: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		self.status = status
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.last else { return }
		self.location = location
		self.geocode()
	}
}
