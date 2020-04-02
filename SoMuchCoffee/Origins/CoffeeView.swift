//
//  CoffeeView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/2/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct CoffeeView: View {
	var coffee: Coffee
	
	@State private var showSheet = false
	
	@EnvironmentObject var allRoasters: Roasters
	
    var body: some View {
		VStack {
			Text(coffee.name).font(.title)
			Text(coffee.roasterID)
			List {
//				.frame(maxWidth: .infinity)
				Text(coffee.originID)
				NavigationLink(destination: RoasterView(roaster: allRoasters.roasterFromID(coffee.roasterID))) {
					Text(allRoasters.roasterNameFromID(coffee.roasterID))
				}
				WebsiteRow(url: coffee.url)
			}
		}
    }
}

struct CoffeeView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			CoffeeView(coffee: Coffee.example)
		}
    }
}
