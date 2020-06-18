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
				Section (header: Text("Single Origin")) {
					ForEach(origin.coffees.filter("origins.@count == 1")) {coffee in
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
					if (origin.coffees.filter("origins.@count == 1").count == 0) {
						Text("None listed from this origin")
					}
				}
				Section (header: Text("Blends")) {
					ForEach(origin.coffees.filter("origins.@count > 1")) {coffee in
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
					if (origin.coffees.filter("origins.@count > 1").count == 0) {
						Text("None listed from this origin")
					}
				}
				Section (header: Text("Learn More")) {
					if (origin.wikiURL != nil) { DetailRow(style: .wikiURL, value: origin.wikiURL, entity: origin) }
					if (origin.atlasURL != nil) { DetailRow(style: .atlasURL, value: origin.atlasURL, entity: origin) }
					if (origin.cafeImportURL != nil) { DetailRow(style: .cafeImportURL, value: origin.cafeImportURL, entity: origin) }
					if (origin.otherURL1 != nil) { DetailRow(style: .otherURL1, value: origin.otherURL1, entity: origin) }
					if (origin.otherURL2 != nil) { DetailRow(style: .otherURL2, value: origin.otherURL2, entity: origin) }
				}
			}
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
