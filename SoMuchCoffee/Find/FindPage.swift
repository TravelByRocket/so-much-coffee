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
				}
				List (shops.allWithinMapAreaSorted, id: \.shop.id) {shop in
					NavigationLink (destination: Text("You are somewhere. Go back.")){
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

