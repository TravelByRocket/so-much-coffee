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
			VStack {
				ZStack {
					Color.white.edgesIgnoringSafeArea(.all)
					FlavorWheel(isZoomed: $isZoomed)
					VStack {
						ZStack {
							Text(!isZoomed ? "Flavor Wheel" : "").font(.largeTitle)
							HStack{
								Spacer()
								GoHome()
									.padding(5)
							}
						}
						.padding()
						.foregroundColor(Color.black)
						Spacer()
						if !isZoomed {
							Button(action: {self.sheetIsPresented = true} ) {
								Text("Chart Courtesy of Counter Culture Coffee")
									.font(.caption)
							}
						}
					}
				}
			}
			.sheet(isPresented: $sheetIsPresented) {
			SafariView(url:URL(string: "https://counterculturecoffee.com/learn/resource-center/coffee-tasters-flavor-wheel")!) }
	}
}

struct FlavorsPage_Previews: PreviewProvider {
	static var previews: some View {
		FlavorsPage()
	}
}

struct FlavorWheel: View {
	@Binding var isZoomed: Bool
	var body: some View {
		VStack {
			if isZoomed {
				ScrollView ([.horizontal, .vertical], showsIndicators: false) {
					Image("flavorwheel")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.offset(x: 450, y: 450)
						.frame(width: 1500)
				}
			} else {
				Image(systemName: "plus.magnifyingglass").foregroundColor(Color.black).font(.largeTitle)
				Image("flavorwheel")
					.resizable()
					.aspectRatio(contentMode: .fit)
			}
		}
		.onTapGesture {withAnimation {self.isZoomed.toggle()}}
	}
}
