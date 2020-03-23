//
//  OriginsPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/24/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct OriginsPage: View {
	let urlByCountry = ["Angola": "https://en.wikipedia.org/wiki/Coffee_production_in_Angola",
							"Bolivia": "https://en.wikipedia.org/wiki/Coffee_production_in_Bolivia",
							"Brazil": "https://en.wikipedia.org/wiki/Coffee_production_in_Brazil",
							"China": "https://en.wikipedia.org/wiki/Coffee_production_in_China",
							"Cameroon": "https://en.wikipedia.org/wiki/Coffee_production_in_Cameroon",
							"Colombia": "https://en.wikipedia.org/wiki/Coffee_production_in_Colombia",
							"Costa Rica": "https://en.wikipedia.org/wiki/Coffee_production_in_Costa_Rica",
							"Cuba": "https://en.wikipedia.org/wiki/Coffee_production_in_Cuba",
							"Democratic Republic of the Congo": "https://en.wikipedia.org/wiki/Coffee_production_in_Democratic_Republic_of_the_Congo",
							"The Dominican Republic": "https://en.wikipedia.org/wiki/Coffee_production_in_the_Dominican_Republic",
							"Ecuador": "https://en.wikipedia.org/wiki/Coffee_production_in_Ecuador",
							"El Salvador": "https://en.wikipedia.org/wiki/Coffee_production_in_El_Salvador",
							"Ethiopia": "https://en.wikipedia.org/wiki/Coffee_production_in_Ethiopia",
							"Guatemala": "https://en.wikipedia.org/wiki/Coffee_production_in_Guatemala",
							"Haiti": "https://en.wikipedia.org/wiki/Coffee_production_in_Haiti",
							"Hawaii": "https://en.wikipedia.org/wiki/Coffee_production_in_Hawaii",
							"Honduras": "https://en.wikipedia.org/wiki/Coffee_production_in_Honduras",
							"India": "https://en.wikipedia.org/wiki/Coffee_production_in_India",
							"Indonesia": "https://en.wikipedia.org/wiki/Coffee_production_in_Indonesia",
							"Ivory Coast": "https://en.wikipedia.org/wiki/Coffee_production_in_Ivory_Coast",
							"Jamaica": "https://en.wikipedia.org/wiki/Coffee_production_in_Jamaica",
							"Kenya": "https://en.wikipedia.org/wiki/Coffee_production_in_Kenya",
							"Laos": "https://en.wikipedia.org/wiki/Coffee_production_in_Laos",
							"Mexico": "https://en.wikipedia.org/wiki/Coffee_production_in_Mexico",
							"Nicaragua": "https://en.wikipedia.org/wiki/Coffee_production_in_Nicaragua",
							"Panama": "https://en.wikipedia.org/wiki/Coffee_production_in_Panama",
							"Papua New Guinea": "https://en.wikipedia.org/wiki/Coffee_production_in_Papua_New_Guinea",
							"Paraguay": "https://en.wikipedia.org/wiki/Coffee_production_in_Paraguay",
							"Peru": "https://en.wikipedia.org/wiki/Coffee_production_in_Peru",
							"The Philippines": "https://en.wikipedia.org/wiki/Coffee_production_in_the_Philippines",
							"Puerto Rico": "https://en.wikipedia.org/wiki/Coffee_production_in_Puerto_Rico",
							"Sri Lanka": "https://en.wikipedia.org/wiki/Coffee_production_in_Sri_Lanka",
							"Tanzania": "https://en.wikipedia.org/wiki/Coffee_production_in_Tanzania",
							"Thailand": "https://en.wikipedia.org/wiki/Coffee_production_in_Thailand",
							"Uganda": "https://en.wikipedia.org/wiki/Coffee_production_in_Uganda",
							"Venezuela": "https://en.wikipedia.org/wiki/Coffee_production_in_Venezuela",
							"Vietnam": "https://en.wikipedia.org/wiki/Coffee_production_in_Vietnam"
	]
	
	var body: some View {
		NavigationView {
			VStack {
				ZStack {
					Color.blue.opacity(0.7).mask(RoundedRectangle(cornerRadius: 35.0)).blur(radius: 1.0)
					NavigationLink(destination: RegionAfrica(urlByCountry: urlByCountry), label: { Text("Africa") }).font(.title).foregroundColor(Color.primary)
				}.padding(.horizontal,60).padding(.vertical,20)
				ZStack {
					Color.red.opacity(0.7).mask(RoundedRectangle(cornerRadius: 35.0)).blur(radius: 1.0)
					NavigationLink(destination: RegionAsia(urlByCountry: urlByCountry), label: { Text("Asia") }).font(.title).foregroundColor(Color.primary)
				}.padding(.horizontal,60).padding(.vertical,20)
				ZStack {
					Color.purple.opacity(0.7).mask(RoundedRectangle(cornerRadius: 35.0)).blur(radius: 1.0)
					NavigationLink(destination: RegionNorthAmerica(urlByCountry: urlByCountry), label: { Text("North America") }).font(.title).foregroundColor(Color.primary)
				}.padding(.horizontal,60).padding(.vertical,20)
				ZStack {
					Color.green.opacity(0.7).mask(RoundedRectangle(cornerRadius: 35.0)).blur(radius: 1.0)
					NavigationLink(destination: RegionSouthAmerica(urlByCountry: urlByCountry), label: { Text("South America") }).font(.title).foregroundColor(Color.primary)
				}.padding(.horizontal,60).padding(.vertical,20)
			}
			.padding(.top,30)
			.navigationBarTitle("Origins by Continent")
			.navigationBarItems(trailing: GoHome())
		}
	}
}

struct OriginsPage_Previews: PreviewProvider {
	static var previews: some View {
		OriginsPage()
	}
}
