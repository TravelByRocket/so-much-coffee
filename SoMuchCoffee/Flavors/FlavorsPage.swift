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
	@State var sheetIsPresented = false
	
	var body: some View {
		NavigationView {
			VStack {
				ZStack {
					Color.white
					if isZoomed {
						ScrollView ([.horizontal, .vertical], showsIndicators: false) {
							Image("flavorwheel")
								.resizable()
								.offset(x: 150, y: 20)
						}
					} else {
						Image("flavorwheel")
							.resizable()
							.aspectRatio(contentMode: .fit)
					}
					
				}
				.onTapGesture {withAnimation {self.isZoomed.toggle()}}
//				Spacer()
				if !isZoomed {
					Button(action: {self.sheetIsPresented = true} ) {
						Text("Chart Courtesy of Counter Culture Coffee")
							.font(.caption)
					}
				}
				
			}
			.navigationBarTitle(isZoomed ? "" : "Flavor Wheel")
			.navigationBarItems(trailing: GoHome())
			.sheet(isPresented: $sheetIsPresented) {
			SafariView(url:URL(string: "https://counterculturecoffee.com/learn/resource-center/coffee-tasters-flavor-wheel")!) }
		}
	}
}

struct FlavorsPage_Previews: PreviewProvider {
	static var previews: some View {
		FlavorsPage()
	}
}
