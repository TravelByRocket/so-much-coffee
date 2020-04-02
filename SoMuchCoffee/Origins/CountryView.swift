//
//  CountryView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/2/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct CountryView: View {
	var country: String
	
	var allCoffees: [Coffee] = Bundle.main.decode([Coffee].self, from: "coffees.json")
	
	@EnvironmentObject var allRoasters: Roasters
	
    var body: some View {
		VStack {
			Text(country).font(.title)
			Text("Single origin coffees")
			List(allCoffees.filter { $0.originID == country }.sorted(), id: \.self) {coffee in
				NavigationLink(destination: CoffeeView(coffee: coffee)) {
					//		List(allCoffees.sorted(), id: \.self) {coffee in
					VStack (alignment: .leading) {
						Text(coffee.name)
						Text(self.allRoasters.roasterNameFromID(coffee.roasterID))
							.foregroundColor(Color.secondary)
							.font(.caption)
					}
					//		}
				}
			}
			Spacer()
		}
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(country: "burundi")
    }
}
