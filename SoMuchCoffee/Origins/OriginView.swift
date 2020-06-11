//
//  CountryView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/2/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct OriginView: View {
	var origin: OriginJSON
	
	var allCoffees: [CoffeeJSON] = Bundle.main.decode([CoffeeJSON].self, from: "coffees.json")
	
	@EnvironmentObject var allRoasters: Roasters
	
    var body: some View {
		VStack {
			Text("Roasts from \(origin.name)").font(.title).padding().multilineTextAlignment(.center)
			List {
				Section (header: Text("Roasts")) {
					ForEach(allCoffees.filter { $0.originID == origin.id }.sorted(), id: \.self) {coffee in
						NavigationLink(destination: CoffeeView(coffee: coffee)) {
							VStack (alignment: .leading) {
								Text(coffee.name)
								HStack {
									Text(self.allRoasters.roasterNameFromID(coffee.roasterID))
									Spacer()
									Text(self.allRoasters.roasterFromID(coffee.roasterID).locationShort)
								}
								.foregroundColor(Color.secondary)
								.font(.caption)
							}
						}
					}
				}
				Section (header: Text("Learn More")) {
					ResourcesView(urls: [ // hack-y to the point of sadness but it is working as desired
						origin.wikiURL,
						origin.atlasURL,
						origin.cafeImportURL,
						origin.otherURL1,
						origin.otherURL2
					])
				}
			}
		}
    }
}

struct ResourcesView: View {
	let urls: [String]
	let labels = ["Wikipedia","Atlas Coffee Importers","Cafe Imports","Other URL 1","Other URL 2"]
	
	var merged: [(String, String)] {
		return [ // this is so bad but having issues with loops, typing, initializing with tuple
			(urls[0],labels[0]),
			(urls[1],labels[1]),
			(urls[2],labels[2]),
			(urls[3],labels[3]),
			(urls[4],labels[4])
		]
	}
	
	var body: some View {
		ForEach (merged.filter { $0.0 != "" }, id: \.1) {pair in
			DetailRowActionableFA(name: .globe, type: .solid, str: pair.1, url: pair.0, rawString: pair.0)
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
