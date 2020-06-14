//
//  FindPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 6/14/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI
import MapKit
import RealmSwift

struct FindPage: View {
	var shops: RealmSwift.Results<Shop> = realm.objects(Shop.self)
	let bufferFactor = 1.2
	
	@EnvironmentObject var mapStatus: MapStatusManager
	@ObservedObject var lm = LocationManager()
	
	@State private var locationSource: LocationSource = .userLocation
		
	enum LocationSource {
		case shopsCenter, userLocation
	}
	
	@State private var showList = true
	
	var body: some View {
		print("aaa lm is \(String(describing: lm.location?.coordinate)) with status \(String(describing: lm.status))")
		return NavigationView {
			VStack {
				ZStack {
					MapViewResults(shops: shops, centerCoordinate: shops.centerCoordinate, latitudeDelta: shops.latitudeDelta * bufferFactor, longitudeDelta: shops.longitudeDelta * bufferFactor, keepMapLocation: true)
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
					List (shops) {shop in
						NavigationLink (destination: ShopPage(shop: shop)){
							VStack {
								Text(shop.name)
								Text("fix ShopRow needing distance as Shop")
//								ShopRow(shop: shop) // location for distance is provided through the Shops class
							}
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
		.environmentObject(MapStatusManager())
    }
}
