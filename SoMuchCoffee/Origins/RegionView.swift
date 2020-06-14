//
//  RegionView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/2/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RegionView: View {
	var regionName: String
	let origins = Origins.everyFromJSON
	let allCoffee = Coffees.everyFromJSON
	let allOrigins = Origins.all
	
    var body: some View {
		VStack {
			Text(regionName).font(.largeTitle)
			List(origins.filter { $0.regionName == self.regionName }, id: \.self) { origin in
				NavigationLink (destination: OriginViewJSON(origin: origin)) {
					Image(systemName: "\(self.allCoffee.filter { $0.originID == origin.id }.count).circle")
					Text(self.allOrigins.originFromID(origin.id).name)
				}
			}
		}
    }
}

struct RegionView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			RegionView(regionName: "South America")
		}
    }
}
