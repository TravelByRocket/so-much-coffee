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
			MapView(shopContainer: Shops(oneShop: shop), centerCoordinate: shop.latlon, latlonDelta: 0.01, showMarker: true)
				.navigationBarTitle(shop.name)
			List {
				Section (header: Text("Support During COVID-19")) {
					Text("Notes about where to order coffee, tip baristas, etc.")
				}
				Section (header: Text("Coffee Served")) {
					Text("Espresso X served every day")
					Text("Espresso Y served Mon-Thu")
					Text("A single-origin espresso is served Fri-Sun")
				}
				Section (header: Text("Supplying Roasters")) {
					Text("Roaster 1 (tap for roaster profile in future)")
					Text("Roaster 2 > ")
				}
				Section (header: Text("Atmosphere & Features")) {
					Text("(Range of beverages)")
					Text("(Food)")
					Text("(WiFi)")
					Text("(Power Outlets)")
					Text("(Good for studying)")
					Text("(Good for socializing)")
				}
				Section (header: Text("Online & Social")) {
					Text("Website: ")
					Text("Instagram: ")
					Text("Facebook: ")
					Text("Twitter: ")
					Text("FourSquare/Swarm: ")
				}
				Section (header: Text("Contact")) {
					Text(shop.address)
					Text("(Phone)")
					Text("(Hours)")
				}
			}
		}
    }
}

struct ShopView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ShopView(shop: Shop(id: "anything", name: "Some Great Place", address: "1234 Here St", latitude: 40, longitude: 104))
		}
    }
}
