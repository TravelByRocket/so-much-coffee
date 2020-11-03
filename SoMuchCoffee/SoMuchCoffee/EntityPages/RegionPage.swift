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
			List(realm.objects(Origin.self)
				.sorted(byKeyPath: "name")
				.filter { $0.region.rawValue == regionName }
			) { origin in
				NavigationLink (destination: OriginPage(origin: origin)) {
					Text(origin.name)
				}
			}
		}
        .navigationTitle(regionName)
        .navigationBarHidden(false)
    }
}

struct RegionPage_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			RegionPage(regionName: realm.objects(Origin.self).randomElement()?.region.rawValue ?? "Other")
		}
    }
}
