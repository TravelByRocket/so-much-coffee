//
//  CoffeePage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 6/11/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct CoffeePage: View {
	let coffee: Coffee
	
    var body: some View {
		VStack {
			Text(coffee.name).font(.largeTitle).multilineTextAlignment(.center).padding()
			Text("from \(coffee.origins[0].name)")
			Text("by \(coffee.roaster!.name)")
			List {
				Section (header: Text("Explore")) {
//					NavigationLink (destination: RegionView(regionName: allOrigins.originFromID(coffee.originID).regionName)) {
					NavigationLink (destination: Text("Placeholder")) {
//						Text(coffee.origins[0].region.rawValue)
						Text(coffee.origins.map { $0.region.rawValue }.joined(separator: ", "))
					}
//					NavigationLink (destination: OriginView(origin: allOrigins.originFromID(coffee.originID))) {
					NavigationLink (destination: Text("Placeholder")) {
//						Text(coffee.origins[0].name)
						Text(coffee.origins.map{ $0.name }.joined(separator: ", "))
					}
					NavigationLink(destination: RoasterView(roaster: coffee.roaster!)) {
						Text(coffee.roaster!.name)
					}
				}
				Section (header: Text("Order Online")) {
					DetailRowDisplayOnly(symbol: "dollarsign.square.fill", str: ("Offer Details: "+(coffee.roaster?.offerDetails ?? "")))
					DetailRowDisplayOnly(symbol: "barcode", str: ("Offer Code: "+(coffee.roaster?.offerCode ?? "")))
					WebsiteRow(url: coffee.url!, msg: "\(coffee.name) Product Page")
				}
			}
		}
    }
}

struct CoffeePage_Previews: PreviewProvider {
	static var previews: some View {
		CoffeePage(coffee: realm.objects(Coffee.self).randomElement()!)
    }
}
