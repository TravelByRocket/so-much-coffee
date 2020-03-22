//
//  ShopView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/24/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct ShopView: View {
	var shop: Shop
	var body: some View {
		VStack {
//			MapView(shopContainer: Shops(oneShop: shop), center: shop.latlon, latlonDelta: 0.01, showMarker: true)
//				.navigationBarTitle(shop.name)
			Text("Hi, you've reached the page for \(shop.name)")
				.navigationBarTitle(shop.name)
			List {
				Text("Hours")
				Text("Address")
				Text("Phone")
				Text("Instagram")
				Text("Twitter")
				Text("Facebook")
				Text("Food")
				Text("Internet")
				Text("Power")
				Text("Power")
//				Text("Power")
//				Text("Power")
			}
			
		}
    }
}

//struct ShopView_Previews: PreviewProvider {
//	static var previews: some View {
//		NavigationView {
//			ShopView(shop: fakeShop)
//		}
//    }
//}
