//
//  RegionPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 6/14/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI
import RealmSwift

struct RegionPage: View {
	var regionName: String
	
    var body: some View {
		VStack {
			Text(regionName).font(.largeTitle)
			List(realm.objects(Origin.self)
				.sorted(byKeyPath: "name")
				.filter { $0.region.rawValue == regionName }
			) { origin in
				NavigationLink (destination: OriginPage(origin: origin)) {
					Image(systemName: "\(origin.coffees.count).circle") // TODO protect for >50
					Text(origin.name)
				}
			}
		}
    }
}

struct RegionPage_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			RegionPage(regionName: realm.objects(Origin.self).randomElement()?.region.rawValue ?? "Other")
		}
    }
}
