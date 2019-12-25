//
//  FlavorsPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/24/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct FlavorsPage: View {
	@State var isZoomed = false
	var body: some View {
		NavigationView {
			VStack {
				HStack {
					Spacer()
					GoHome().padding().navigationBarTitle("Flavors")
				}

				if isZoomed {
					ScrollView ([.horizontal, .vertical], showsIndicators: false) {
						Image("flavorwheel")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.offset(x: 150, y: 200)
							.onTapGesture {withAnimation {self.isZoomed.toggle()}}
					}
				} else {
					Image("flavorwheel")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.onTapGesture {withAnimation {self.isZoomed.toggle()}}
				}
				Spacer()
				Text("Chart Courtesy of Counter Culture Coffee").font(.caption)
//				Text("https://counterculturecoffee.com/learn/resource-center/coffee-tasters-flavor-wheel").font(.caption)
//				Spacer()
			}
		}
		
	}
}

struct FlavorsPage_Previews: PreviewProvider {
	static var previews: some View {
		FlavorsPage()
	}
}
