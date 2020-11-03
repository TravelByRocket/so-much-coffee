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
			List {
				Section (header: Text("Resources")) {
					if (origin.wikiURL != nil) { DetailRow(style: .wikiURL, value: origin.wikiURL, entity: origin) }
					if (origin.atlasURL != nil) { DetailRow(style: .atlasURL, value: origin.atlasURL, entity: origin) }
					if (origin.cafeImportURL != nil) { DetailRow(style: .cafeImportURL, value: origin.cafeImportURL, entity: origin) }
					if (origin.otherURL1 != nil) { DetailRow(style: .otherURL1, value: origin.otherURL1, entity: origin) }
					if (origin.otherURL2 != nil) { DetailRow(style: .otherURL2, value: origin.otherURL2, entity: origin) }
				}
			}
            .listStyle(GroupedListStyle())
            .navigationTitle(origin.name)
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
