//
//  FindPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/24/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI
import MapKit

struct FindPage: View {
	@EnvironmentObject var allShops: Shops
	@EnvironmentObject var allRoasters: Roasters
	@ObservedObject var lm = LocationManager()
	
	@State private var locationSource: LocationSource = .shopsCenter
	
	var latitudeDelta: Double {
		switch locationSource {
		case .shopsCenter:
			return allShops.latitudeDeltaOfShops
		case .userLocation:
			if lm.status == .authorizedWhenInUse {
				return 0.03
			} else {
				return 0.20
			}
		}
	}
	var longitudeDelta: Double {
		switch locationSource {
		case .shopsCenter:
			return allShops.longitudeDeltaOfShops
		case .userLocation:
			if lm.status == .authorizedWhenInUse {
				return 0.03
			} else {
				return 0.20
			}
		}
	}
	
	var centerCoordinate: CLLocationCoordinate2D {
		switch locationSource {
		case .shopsCenter:
			return allShops.centerOfShops
		case .userLocation:
			return CLLocationCoordinate2D(latitude: (lm.location?.coordinate.latitude)!, longitude: (lm.location?.coordinate.longitude)!)
		}
	}
	
	enum LocationSource {
		case shopsCenter, userLocation
	}

	var body: some View {
		NavigationView {
			VStack {
				ZStack {
					MapView(shops: allShops, centerCoordinate: centerCoordinate, latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
						.navigationBarTitle("Find a Shop")
						.navigationBarItems(trailing: GoHome())
//					Circle()
//						.frame(width: 10, height: 10)
//						.foregroundColor(Color.gray.opacity(0.5))
					Image(systemName: "smallcircle.circle")
					
//					HStack { // hack-y solution to pushing the locator button to the upper-right
//						Spacer()
//						VStack {
//							Image(systemName: "location.fill")
//								.foregroundColor(Color.blue)
//								.frame(width:10, height: 10)
//								.padding(10)
//								.background(Color.gray.opacity(0.6))
//								.overlay(RoundedRectangle(cornerRadius: 4.0).stroke(lineWidth: 0.5))
//								.padding(10)
//								.onTapGesture {
//									self.locationSource = .userLocation
//							}
//							Spacer()
//						}
//					}
				}
				List (allShops.allWithinMapAreaSorted, id: \.shop.id) {shop in
					NavigationLink (destination: ShopView(shop: shop.shop)){
						ShopRow(shop: shop) // location for distance is provided through the Shops class
					}
				}
			}
		}
	}	
}

struct FindPage_Previews: PreviewProvider {
	static var previews: some View {
		FindPage()
	}
}

