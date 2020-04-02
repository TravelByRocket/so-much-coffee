//
//  CountryView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/2/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct OriginView: View {
	var origin: Origin
	
	var allCoffees: [Coffee] = Bundle.main.decode([Coffee].self, from: "coffees.json")
	
	@EnvironmentObject var allRoasters: Roasters
	
    var body: some View {
		VStack {
			Text("Roasts from \(origin.name)").font(.title).padding().multilineTextAlignment(.center)
			List {
				Section (header: Text("Resources")) {
					WebsiteRow(url: origin.wikiURL, msg: "Wikipedia")
					WebsiteRow(url: origin.atlasURL, msg: "Atlas Coffee Importers")
					WebsiteRow(url: origin.cafeImportURL, msg: "Cafe Imports")
					WebsiteRow(url: origin.otherURL1, msg: "Other URL")
					WebsiteRow(url: origin.otherURL2, msg: "Other URL")
				}
				Section (header: Text("Roasts")) {
					ForEach(allCoffees.filter { $0.originID == origin.id }.sorted(), id: \.self) {coffee in
						NavigationLink(destination: CoffeeView(coffee: coffee)) {
							VStack (alignment: .leading) {
								Text(coffee.name)
								Text(self.allRoasters.roasterNameFromID(coffee.roasterID))
									.foregroundColor(Color.secondary)
									.font(.caption)
							}
						}
					}
				}
			}
		}
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			OriginView(origin: Origins.oneFromJSON)
				.environmentObject(Roasters.all)
		}
    }
}
