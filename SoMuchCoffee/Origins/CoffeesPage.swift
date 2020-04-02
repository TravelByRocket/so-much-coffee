//
//  CoffeesPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/1/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct CoffeesPage: View {
	var allCoffees: [Coffee] = Bundle.main.decode([Coffee].self, from: "coffees.json")
	@EnvironmentObject var allRoasters: Roasters
	
	var countries: [String] {
		let set = Set(allCoffees.map { $0.originID })
		let array = Array(set)
		return array.sorted()
	}
	
    var body: some View {
		NavigationView {
			VStack {
				Text("Countries of Origin").font(.largeTitle)
				Text("Single Origin Coffee")
				List(countries, id: \.self) { country in
					NavigationLink (destination: CountryView(country: country)) {
						Image(systemName: "\(self.allCoffees.filter { $0.originID == country }.count).circle")
						Text(country)
					}
				}
			}
		.navigationBarItems(trailing: GoHome())
		}
    }
}

struct CoffeesPage_Previews: PreviewProvider {
    static var previews: some View {
        CoffeesPage()
			.environmentObject(Roasters.load())
    }
}
