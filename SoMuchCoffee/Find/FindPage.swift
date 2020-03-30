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
	@State private var centerCoordinate = CLLocationCoordinate2D(latitude: 40.017564, longitude: -105.282169)
	@EnvironmentObject var allShops: Shops
	@EnvironmentObject var allRoasters: Roasters
	@ObservedObject var lm = LocationManager()
	private var reportingShop = ReportingShop()

	var body: some View {
		NavigationView {
			VStack {
				ZStack {
					MapView(shopContainer: allShops, centerCoordinate: allShops.centerOfShops, latlonDelta: allShops.latlonDeltaOfShops)
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
									self.centerCoordinate.latitude = self.lm.location?.coordinate.latitude ?? 0
									self.centerCoordinate.longitude = self.lm.location?.coordinate.longitude ?? 0
							}
							Spacer()
						}
					}
				}
				List (allShops.allWithinMapAreaSorted, id: \.shop.id) {shop in
					NavigationLink (destination: ShopView(shop: shop.shop).environmentObject(self.reportingShop)){
						ShopRow(centerCoordinate: self.$centerCoordinate, shop: shop)
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

