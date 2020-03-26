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
	@ObservedObject var shops: Shops = Shops()
	@ObservedObject var lm = LocationManager()
	
//	var latitude: String  { return("\(lm.location?.coordinate.latitude ?? 0)") }
//	var longitude: String  { return("\(lm.location?.coordinate.longitude ?? 0)") }

	var body: some View {
		NavigationView {
			VStack {
				ZStack {
					MapView(shopContainer: shops, centerCoordinate: centerCoordinate)
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
//								.mask(Circle())
//								.overlay(Circle().foregroundColor(Color.green.opacity(0.5)))
//								.mask(RoundedRectangle(cornerRadius: 4.0))
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
//				Text("Latitude: \(self.latitude)")
//				Text("Longitude: \(self.longitude)")
				List (shops.allWithinMapAreaSorted, id: \.shop.id) {shop in
					NavigationLink (destination: ShopView(shop: shop.shop)){
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

