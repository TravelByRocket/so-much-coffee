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
	@EnvironmentObject var mapStatus: MapStatusManager
	@ObservedObject var lm = LocationManager()
	
	@State private var locationSource: LocationSource = .userLocation
	
	var latitudeDelta: Double {
		if mapStatus.longitudeSpanFixed != nil {
			return 0.01 // set very small because longitude should rule the sizing in this case
		} else if lm.location?.coordinate != nil {
			return 0.04
		} else {
			return allShops.longitudeDeltaOfShops
		}
	}
	
	var longitudeDelta: Double {
		if let span = mapStatus.longitudeSpanFixed {
			return span
		} else if let center = lm.location?.coordinate {
			mapStatus.centerCoordinateFixed = center
			mapStatus.longitudeSpanFixed = 0.04
			return 0.04
		} else {
			return allShops.longitudeDeltaOfShops
		}
	}
	
	var centerCoordinate: CLLocationCoordinate2D {
		// TODO this would not be able to accomodate a "center on me" option
		if let center = mapStatus.centerCoordinateFixed {
			return center
		} else if let center = lm.location?.coordinate {
			mapStatus.centerCoordinateFixed = center
			return center
		} else {
			return allShops.centerOfShops
		}
	}
	
	enum LocationSource {
		case shopsCenter, userLocation
	}
	
	@State private var showList = true
	
	var body: some View {
		print("aaa lm is \(String(describing: lm.location?.coordinate)) with status \(String(describing: lm.status))")
		return NavigationView {
			VStack {
				ZStack {
					MapViewJSON(shops: allShops, centerCoordinate: centerCoordinate, latitudeDelta: 0.01, longitudeDelta: longitudeDelta, keepMapLocation: true)
						.edgesIgnoringSafeArea(.bottom)
						.navigationBarTitle("Find a Shop")
						.navigationBarItems(leading: ShowHideList(showList: $showList), trailing: GoHome())
						.onAppear() {
							print("msm incoming coord is \(String(describing: self.mapStatus.centerCoordinateFixed))")
					}
					.onDisappear() {
						self.mapStatus.update()
						print("msm map did disappear, called .update()")
					}
					Image(systemName: "smallcircle.circle").opacity(0.7)
				}
				if showList {
					List (allShops.allWithinMapAreaSorted[0 ..< min(allShops.allWithinMapAreaSorted.count,10)], id: \.shop.id) {shop in
						NavigationLink (destination: ShopViewJSON(shop: shop.shop)){
							ShopRow(shop: shop) // location for distance is provided through the Shops class
						}
					}
//					.id(UUID()) // eliminates animation, which I think was the cause of links popping back
				}
			}
			.animation(.default)
		}
	}	
}

struct ShowHideList: View {
	@Binding var showList: Bool
	
	var body: some View {
		HStack {
			Image(systemName: showList ? "arrow.down.square" : "arrow.up.square")
			Text(showList ? "Hide List" : "Show List")
			Spacer()
		}
		.frame(width: 200)
		.onTapGesture {
			self.showList.toggle()
		}
	}
}


struct FindPage_Previews: PreviewProvider {
	static var previews: some View {
		FindPage()
			.environmentObject(Shops.all)
			.environmentObject(Roasters.all)
			.environmentObject(MapStatusManager())
	}
}

