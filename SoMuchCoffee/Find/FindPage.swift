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
	let shops: Shops = Shops()
    
	var body: some View {
		NavigationView {
			VStack {
				ZStack {
					MapView(shops: shops.items, center: shops.items[0].latlon)
						.navigationBarTitle("Find a Shop")
						.navigationBarItems(trailing: GoHome())
					Circle()
						.frame(width: 10, height: 10)
						.foregroundColor(Color.orange.opacity(0.5))
				}
				List {
					ForEach (shops.allWithinMapAreaSorted) {shop in
						NavigationLink (destination: ShopView(shop: shop)){
							HStack {
								Text("\(shop.kilometersAway(from: self.centerCoordinate), specifier: "%4.1f") km")
									.font(Font.custom(monoregular, size: 15))
									.padding(.vertical, 3)
									.padding(.horizontal, 6)
									.overlay(Capsule()
										.stroke(Color.primary))
								Text(shop.name)
							}
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
    }
}
