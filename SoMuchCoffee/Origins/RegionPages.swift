//
//  RegionPages.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/22/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RegionNorthAmerica: View {
	var urlByCountry: [String: String]
	
	@State var showSafari = false
	@State var urlString: String?
	
    var body: some View {
		List {
			Section {
				OriginsRow(country: "Cuba", countryURL: urlByCountry["Cuba"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
				OriginsRow(country: "Haiti", countryURL: urlByCountry["Haiti"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
				OriginsRow(country: "Hawaii", countryURL: urlByCountry["Hawaii"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
				OriginsRow(country: "Jamaica", countryURL: urlByCountry["Jamaica"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
				OriginsRow(country: "Mexico", countryURL: urlByCountry["Mexico"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
				OriginsRow(country: "Puerto Rico", countryURL: urlByCountry["Puerto Rico"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
				OriginsRow(country: "The Dominican Republic", countryURL: urlByCountry["The Dominican Republic"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			}
			Section (header: Text("Central America")){
				OriginsRow(country: "El Salvador", countryURL: urlByCountry["El Salvador"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
				OriginsRow(country: "Costa Rica", countryURL: urlByCountry["Costa Rica"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
				OriginsRow(country: "Guatemala", countryURL: urlByCountry["Guatemala"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
				OriginsRow(country: "Honduras", countryURL: urlByCountry["Honduras"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
				OriginsRow(country: "Nicaragua", countryURL: urlByCountry["Nicaragua"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
				OriginsRow(country: "Panama", countryURL: urlByCountry["Panama"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			}
		}
		.navigationBarTitle("North America")
		.sheet(isPresented: $showSafari) {
			SafariView(url:URL(string: self.urlString ?? "https://en.wikipedia.org/wiki/Portal:Coffee")!)
		}
    }
}

struct RegionSouthAmerica: View {
	var urlByCountry: [String: String]
	
	@State var showSafari = false
	@State var urlString: String?
	
    var body: some View {
		List{
			OriginsRow(country: "Bolivia", countryURL: urlByCountry["Bolivia"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "Brazil", countryURL: urlByCountry["Brazil"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "Colombia", countryURL: urlByCountry["Colombia"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "Ecuador", countryURL: urlByCountry["Ecuador"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "Paraguay", countryURL: urlByCountry["Paraguay"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "Peru", countryURL: urlByCountry["Peru"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "Venezuela", countryURL: urlByCountry["Venezuela"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
		}
		.navigationBarTitle("South America")
		.sheet(isPresented: $showSafari) {
			SafariView(url:URL(string: self.urlString ?? "https://en.wikipedia.org/wiki/Portal:Coffee")!)
		}
    }
}

struct RegionAfrica: View {
	var urlByCountry: [String: String]
	
	@State var showSafari = false
	@State var urlString: String?
	
    var body: some View {
		List {
			OriginsRow(country: "Angola", countryURL: urlByCountry["Angola"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "Cameroon", countryURL: urlByCountry["Cameroon"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "Democratic Republic of the Congo", countryURL: urlByCountry["Democratic Republic of the Congo"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "Ethiopia", countryURL: urlByCountry["Ethiopia"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "Ivory Coast", countryURL: urlByCountry["Ivory Coast"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "Kenya", countryURL: urlByCountry["Kenya"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "Tanzania", countryURL: urlByCountry["Tanzania"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "Uganda", countryURL: urlByCountry["Uganda"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
		}
		.navigationBarTitle("Africa")
		.sheet(isPresented: $showSafari) {
			SafariView(url:URL(string: self.urlString ?? "https://en.wikipedia.org/wiki/Portal:Coffee")!)
		}
    }
}

struct RegionAsia: View {
	var urlByCountry: [String: String]
	
	@State var showSafari = false
	@State var urlString: String?
	
    var body: some View {
		List {
			OriginsRow(country: "China", countryURL: urlByCountry["China"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "India", countryURL: urlByCountry["India"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "Indonesia", countryURL: urlByCountry["Indonesia"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "Laos", countryURL: urlByCountry["Laos"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "Papua New Guinea", countryURL: urlByCountry["Papua New Guinea"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "Sri Lanka", countryURL: urlByCountry["Sri Lanka"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "Thailand", countryURL: urlByCountry["Thailand"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "The Philippines", countryURL: urlByCountry["The Philippines"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
			OriginsRow(country: "Vietnam", countryURL: urlByCountry["Vietnam"] ?? "https://en.wikipedia.org/wiki/Portal:Coffee", urlString: $urlString, showSafari: $showSafari)
		}
		.navigationBarTitle("Asia")
		.sheet(isPresented: $showSafari) {
			SafariView(url:URL(string: self.urlString ?? "https://en.wikipedia.org/wiki/Portal:Coffee")!)
		}
    }
}


//
//struct RegionPages_Previews: PreviewProvider {
//    static var previews: some View {
//        RegionPages()
//    }
//}
