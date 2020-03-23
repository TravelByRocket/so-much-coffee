//
//  OriginsRow.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/22/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct OriginsRow: View {
	let country: String
	let countryURL: String
	@Binding var urlString: String?
	@Binding var showSafari: Bool
	
	var body: some View {
		HStack {
			Text(country)
				.onTapGesture {
					self.urlString = self.countryURL
					self.showSafari = true
			}
			Spacer()
//			Text("Wikipedia")
//			Image(systemName: "arrow.up.right.square")
			Image(systemName: "safari")
		}
	}
}

struct OriginsRow_Previews: PreviewProvider {
	static var previews: some View {
		List {
			OriginsRow(country: "Test County", countryURL: "http://somuchcoffee.co", urlString: .constant(nil), showSafari: .constant(false))
			OriginsRow(country: "Test County", countryURL: "http://somuchcoffee.co", urlString: .constant(nil), showSafari: .constant(false))
			OriginsRow(country: "Test County", countryURL: "http://somuchcoffee.co", urlString: .constant(nil), showSafari: .constant(false))
			OriginsRow(country: "Test County", countryURL: "http://somuchcoffee.co", urlString: .constant(nil), showSafari: .constant(false))
		}
	}
}
