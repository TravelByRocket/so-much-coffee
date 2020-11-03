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
    @State private var searchString = ""
    
    private var filteredOrigins: RealmSwift.Results<Origin> {
        if searchString == "" {
            return realm.objects(Origin.self)
                .sorted(byKeyPath: "name")
        } else {
            return realm.objects(Origin.self)
                .sorted(byKeyPath: "name")
                .filter("name CONTAINS[c] '\(searchString)'")
        }
    }
    
	var body: some View {
		NavigationView {
			VStack {
				List {
					Section (header: Text("Origins by Region")) { // TODO make more concise with ForEach on the enaum but there are issues to solve to make that happen
						NavigationLink (destination: RegionPage(regionName: Origin.Region.AfricaAndMiddleEast.rawValue)) {
							Text(Origin.Region.AfricaAndMiddleEast.rawValue)
						}
						NavigationLink (destination: RegionPage(regionName: Origin.Region.AsiaPacific.rawValue)) {
							Text(Origin.Region.AsiaPacific.rawValue)
						}
						NavigationLink (destination: RegionPage(regionName: Origin.Region.NorthAmerica.rawValue)) {
							Text(Origin.Region.NorthAmerica.rawValue)
						}
						NavigationLink (destination: RegionPage(regionName: Origin.Region.CentralAmerica.rawValue)) {
							Text(Origin.Region.CentralAmerica.rawValue)
						}
						NavigationLink (destination: RegionPage(regionName: Origin.Region.SouthAmerica.rawValue)) {
							Text(Origin.Region.SouthAmerica.rawValue)
						}
					}
                    Section (header: Text("All Origins")) {
                        TextField("Filter origin list", text: $searchString)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                        ForEach(filteredOrigins) { origin in
                            NavigationLink (destination: OriginPage(origin: origin)) {
                                Text(origin.name)
                            }
                        }
                    }
				}
                .listStyle(GroupedListStyle())
                .navigationBarHidden(true)
			}
		}
	}
}

struct OriginsPage_Previews: PreviewProvider {
	static var previews: some View {
		OriginsPage()
	}
}
