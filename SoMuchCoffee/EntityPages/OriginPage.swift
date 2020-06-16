//
//  OriginPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 6/14/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct OriginPage: View {
	var origin: Origin
	
    var body: some View {
		VStack {
			Text("Roasts from \(origin.name)").font(.title).padding().multilineTextAlignment(.center)
			List {
				Section (header: Text("Roasts")) {
					ForEach(origin.coffees) {coffee in
						NavigationLink(destination: CoffeePage(coffee: coffee)) {
							VStack (alignment: .leading) {
								Text(coffee.name)
								HStack {
									Text(coffee.roaster!.name)
									Spacer()
									Text(coffee.roaster!.basedIn ?? "Error")
								}
								.foregroundColor(Color.secondary)
								.font(.caption)
							}
						}
					}
					if origin.coffees.count == 0 {
						Text("No coffees listed from this origin")
					}
				}
				Section (header: Text("Learn More")) {
					ResourcesView(urls: [ // hack-y to the point of sadness but it is working as desired
						origin.wikiURL ?? "",
						origin.atlasURL ?? "",
						origin.cafeImportURL ?? "",
						origin.otherURL1 ?? "",
						origin.otherURL2 ?? ""
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

struct OriginPage_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			OriginPage(origin: realm.objects(Origin.self).randomElement()!)
		}
    }
}
