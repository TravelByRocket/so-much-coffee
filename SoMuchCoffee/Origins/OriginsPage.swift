//
//  CoffeesPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/1/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI
import RealmSwift

struct OriginsPage: View {
	var allCoffee: [CoffeeJSON] = Coffees.everyFromJSON
	var allOrigins: Origins = Origins.all
	
	@EnvironmentObject var allRoasters: Roasters
	
	var originIDs: [String] {
		let set = Set(allCoffee.map { $0.originID })
		let array = Array(set)
		return array.sorted()
	}
	
	var body: some View {
		NavigationView {
			VStack {
				Text("Coffee Origins").font(.largeTitle)
				Text("Only Single Origin Roasts") // TODO This might not be true one day
				List {
					Section (header: Text("By Region")) { // TODO make more concise with ForEach on the enaum but there are issues to solve to make that happen
						NavigationLink (destination: RegionViewJSON(regionName: Origin.Region.AfricaAndMiddleEast.rawValue)) {
							Text(Origin.Region.AfricaAndMiddleEast.rawValue)
						}
						NavigationLink (destination: RegionViewJSON(regionName: Origin.Region.AsiaPacific.rawValue)) {
							Text(Origin.Region.AsiaPacific.rawValue)
						}
						NavigationLink (destination: RegionViewJSON(regionName: Origin.Region.NorthAmerica.rawValue)) {
							Text(Origin.Region.NorthAmerica.rawValue)
						}
						NavigationLink (destination: RegionViewJSON(regionName: Origin.Region.CentralAmerica.rawValue)) {
							Text(Origin.Region.CentralAmerica.rawValue)
						}
						NavigationLink (destination: RegionViewJSON(regionName: Origin.Region.SouthAmerica.rawValue)) {
							Text(Origin.Region.SouthAmerica.rawValue)
						}
					}
					Section (header: Text("All Origins")) {
						ForEach(realm.objects(Origin.self).sorted(byKeyPath: "name")) { origin in
							NavigationLink (destination: OriginPage(origin: origin)) {
								Image(systemName: "\(origin.coffees.count).circle") // TODO protect for >50
								Text(origin.name)
							}
						}
					}
				}
			}
			.navigationBarItems(trailing: GoHome())
		}
	}
}

struct OriginsPage_Previews: PreviewProvider {
	static var previews: some View {
		OriginsPage()
			.environmentObject(Roasters.all)
	}
}
