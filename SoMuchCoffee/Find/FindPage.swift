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
	private var reportingShop = ReportingShop()
	
	@State private var locationSource: LocationSource = .shopsCenter
	
	var latlonDelta: Double {
		switch locationSource {
		case .shopsCenter:
			return allShops.latlonDeltaOfShops
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
					MapView(shopContainer: allShops, centerCoordinate: centerCoordinate, latlonDelta: latlonDelta)
						.navigationBarTitle("Find a Shop")
						.navigationBarItems(trailing: GoHome())
					Circle()
						.frame(width: 10, height: 10)
						.foregroundColor(Color.orange.opacity(0.5))
					HStack { // hack-y solution to pushing the locator button to the upper-right
						Spacer()
						VStack {
							Image(systemName: "location.fill")
								.foregroundColor(Color.blue)
								.frame(width:10, height: 10)
								.padding(10)
								.background(Color.gray.opacity(0.3))
								.overlay(RoundedRectangle(cornerRadius: 4.0).stroke(lineWidth: 0.5))
								.padding(10)
								.onTapGesture {
									self.locationSource = .userLocation
//									self.centerCoordinate.latitude = self.lm.location?.coordinate.latitude ?? 0
//									self.centerCoordinate.longitude = self.lm.location?.coordinate.longitude ?? 0
							}
							Spacer()
						}
					}
				}
				List (allShops.allWithinMapAreaSorted, id: \.shop.id) {shop in
					NavigationLink (destination: ShopView(shop: shop.shop).environmentObject(self.reportingShop)){
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

