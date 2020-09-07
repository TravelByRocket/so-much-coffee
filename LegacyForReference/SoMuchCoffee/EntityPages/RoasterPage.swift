//
//  RoasterView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 6/11/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI
import RealmSwift

struct RoasterPage: View {
	var roaster: Roaster
	let mapBufferFactor = 1.2
	
    var body: some View {
		VStack {
			MapView(shops: roaster.shopsServing,
					centerCoordinate: roaster.shopsServing.centerCoordinate,
					latitudeDelta: roaster.shopsServing.latitudeDelta * mapBufferFactor,
					longitudeDelta: roaster.shopsServing.longitudeDelta * mapBufferFactor)
			NameTitle(name: roaster.name)
			SummaryBlock(summary: roaster.summary)
			List {
				Section (header: Text("Locations Serving")) {
					ForEach (roaster.shopsServing.sorted(byKeyPath: "name")) {shop in
						NavigationLink(destination: ShopPage(shop: shop)) {
							HStack {
								Image(systemName: shop.affiliatedRoaster != nil ? "link.circle.fill" : "smallcircle.fill.circle")
								Text(shop.name)
							}
						}
					}
				}
				Section (header: Text("Roasts")) {
					ForEach(roaster.coffees.sorted(byKeyPath: "name")) {coffee in
						NavigationLink(destination: CoffeePage(coffee: coffee)) {
							VStack (alignment: .leading) {
								Text(coffee.name)
								Text(coffee.origins.map{$0.name}.joined(separator: ", "))
									.foregroundColor(Color.secondary)
									.font(.caption)
							}
						}
					}
				}
				Section (header: Text("More Details")){
					DetailRow(style: .instagram, value: roaster.instagram, entity: roaster)
					
					HStack {
						Image(systemName: "equal.circle.fill")
						Text("Fair Trade: \(fairTradeString())")
					}
					
					DetailRow(style: .offerDetails, value: roaster.offerDetails, entity: roaster)
					DetailRow(style: .offerCode, value: roaster.offerCode, entity: roaster)
					
					DetailRow(style: .orderURL, value: roaster.orderingURL, entity: roaster)
					DetailRow(style: .subscribeURL, value: roaster.subscriptionURL, entity: roaster)
				}
			}
		}
		.edgesIgnoringSafeArea(.top)
    }
	
	func fairTradeString() -> String {
		if (roaster.isFairtrade.value == nil) {
			return "Unknown"
		} else if (roaster.isFairtrade.value == true) {
			return "Yes"
		} else {
			return "No"
		}
	}
	
}

struct RoasterView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			RoasterPage(roaster: realm.objects(Roaster.self).randomElement()!)
		}
		.navigationBarTitle("Shop Name")
    }
}
