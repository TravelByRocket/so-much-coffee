//
//  CoffeesPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/1/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct CoffeesPage: View {
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
				Text("Only Single Origin Roasts")
				List {
					Section (header: Text("By Region")) {
						ForEach(allOrigins.regionNames, id: \.self) {region in
							NavigationLink (destination: RegionView(regionName: region)) {
								Text(region)
							}
						}
					}
					Section (header: Text("All Origins")) {
						ForEach(originIDs, id: \.self) { originID in
							NavigationLink (destination: OriginView(origin: self.allOrigins.originFromID(originID))) {
								Image(systemName: "\(self.allCoffee.filter { $0.originID == originID }.count).circle")
								Text(self.allOrigins.originFromID(originID).name)
							}
						}
					}
				}
				
//				List(originIDs, id: \.self) { originID in
//					NavigationLink (destination: OriginView(origin: self.allOrigins.originFromID(originID))) {
//						Image(systemName: "\(self.allCoffee.filter { $0.originID == originID }.count).circle")
//						Text(self.allOrigins.originFromID(originID).name)
//					}
//				}
			}
		.navigationBarItems(trailing: GoHome())
		}
    }
}

struct CoffeesPage_Previews: PreviewProvider {
    static var previews: some View {
        CoffeesPage()
			.environmentObject(Roasters.all)
    }
}
