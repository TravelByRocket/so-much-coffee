//
//  CoffeeView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/2/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct CoffeeView: View {
	let coffee: CoffeeJSON
	
	let allCoffees = Coffees.all
	let allOrigins = Origins.all
	
	@EnvironmentObject var allRoasters: Roasters

	var roaster: RoasterJSON {
		allRoasters.roasterFromID(coffee.roasterID)
	}
	
    var body: some View {
		VStack {
			Text(coffee.name).font(.largeTitle).multilineTextAlignment(.center).padding()
			Text("from \(allOrigins.originFromID(coffee.originID).name)")
			Text("by \(roaster.name)")
			List {
				Section (header: Text("Explore")) {
					NavigationLink (destination: RegionView(regionName: allOrigins.originFromID(coffee.originID).regionName)) {
						Text(allOrigins.originFromID(coffee.originID).regionName)
					}
					NavigationLink (destination: OriginView(origin: allOrigins.originFromID(coffee.originID))) {
						Text(allOrigins.originFromID(coffee.originID).name)
					}
					NavigationLink(destination: RoasterView(roaster: roaster)) {
						Text(allRoasters.roasterFromID(coffee.roasterID).name)
					}
				}
				Section (header: Text("Order Online")) {
					DetailRowDisplayOnly(symbol: "dollarsign.square.fill", str: ("Offer Details: "+roaster.code))
					DetailRowDisplayOnly(symbol: "barcode", str: ("Offer Code: "+roaster.code))
					WebsiteRow(url: coffee.url, msg: "\(coffee.name) Product Page")
				}
			}
		}
    }
}

struct CoffeeView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			CoffeeView(coffee: Coffees.oneFromJSON)
				.environmentObject(Roasters.all)
		}
    }
}
