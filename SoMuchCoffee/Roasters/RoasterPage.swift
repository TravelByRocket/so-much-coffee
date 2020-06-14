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
			MapViewLinkingObjects(shops: roaster.shopsServing,
					centerCoordinate: roaster.shopsServing.centerCoordinate,
					latitudeDelta: roaster.shopsServing.latitudeDelta * mapBufferFactor,
					longitudeDelta: roaster.shopsServing.longitudeDelta * mapBufferFactor)
			Text(roaster.name).font(.title).multilineTextAlignment(.center).padding(.horizontal)
			Text(roaster.summary ?? "No summary yet").multilineTextAlignment(.leading).padding(.horizontal)
			List {
				Section (header: Text("Locations Serving")) {
					ForEach (roaster.shopsServing.sorted(byKeyPath: "name")) {shop in
						NavigationLink(destination: ShopPage(shop: shop)) {
							DetailRowDisplayOnly(symbol: (shop.affiliatedRoaster != nil ? "link.circle.fill" : "smallcircle.fill.circle"), str: shop.name)
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
					InstagramRow(instagramHandle: roaster.instagram ?? "") // TODO handle the nil cases within the View
					
					if roaster.isFairtrade.value != nil {
						DetailRowDisplayOnly(symbol: "equal.circle.fill", str: ("Fair Trade: " + (roaster.isFairtrade.value! ? "Yes" : "No") ))
					} else {
						DetailRowDisplayOnly(symbol: "equal.circle.fill", str: ("Fair Trade: Unknown"))
					}
					
					if roaster.offerDetails != nil {
						DetailRowDisplayOnly(symbol: "dollarsign.square.fill", str: ("Offer: " + roaster.offerDetails!))
					} else {
						DetailRowDisplayOnly(symbol: "dollarsign.square.fill", str: ("Offer: Unknown"))
					}
					
					if roaster.offerCode != nil {
						DetailRowDisplayOnly(symbol: "barcode", str: ("Offer: " + roaster.offerCode!))
					} else {
						DetailRowDisplayOnly(symbol: "barcode", str: ("Offer: Unknown"))
					}
					
					DetailRowActionableFA(name: .globe, type: .solid, str: "Order Beans", url: roaster.orderingURL ?? "", rawString: roaster.orderingURL ?? "", noun: "ordering")
					DetailRowActionableFA(name: .globe, type: .solid, str: "Bean Subscription", url: roaster.subscriptionURL ?? "", rawString: roaster.subscriptionURL ?? "", noun: "subscription")
				}
			}
		}
		.edgesIgnoringSafeArea(.top)
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
