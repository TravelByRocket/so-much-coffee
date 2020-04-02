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
	
	@State private var showList = true

	var body: some View {
		NavigationView {
			VStack {
				ZStack {
					MapView(shops: allShops, centerCoordinate: centerCoordinate, latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
						.edgesIgnoringSafeArea(.bottom)
						.navigationBarTitle("Find a Shop")
						.navigationBarItems(trailing:
								GoHome()
					)
					Image(systemName: "smallcircle.circle").opacity(0.7)

					HStack {
						Spacer()
						VStack {
							Spacer()
							Image(systemName: "arrow.up.arrow.down.square").font(.title).padding()
								.onTapGesture {
									withAnimation {
										self.showList.toggle()
									}
							}
						}
					}
				}
				if showList {
					List (allShops.allWithinMapAreaSorted, id: \.shop.id) {shop in
						NavigationLink (destination: ShopView(shop: shop.shop)){
							ShopRow(shop: shop) // location for distance is provided through the Shops class
						}
					}
				}
			}
		}
	}	
}

struct FindPage_Previews: PreviewProvider {
	static var previews: some View {
		FindPage()
		.environmentObject(Shops.example)
		.environmentObject(Roasters())
	}
}

