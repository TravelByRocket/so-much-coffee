//
//  MainPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/15/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct MainPage: View {
	var body: some View {
		VStack {
			// TITLE
			Spacer()
			Text("So Much Coffee")
				.foregroundColor(Color("appOrange"))
				.font(Font.custom(alfa,size: 40))
				.multilineTextAlignment(.center)
				.frame(maxHeight: .infinity)
			Spacer()
			// FIRST ROW
			HStack (alignment: .bottom) {
				NavItem(imageName: "find", label: "Shops", destinationName: "FIND")
					.frame(maxWidth: .infinity)
				Divider()
				VStack {
					Image(systemName: "calendar")
						.resizable()
						.aspectRatio(contentMode: .fit)
					Text("Events")
				}
				.foregroundColor(Color.gray)
				.frame(maxWidth: .infinity)
			}
			.padding([.leading, .trailing])
			.padding(.bottom, 0)
			
			Divider()
			
			//SECOND ROW
			HStack (alignment: .bottom) {
				NavItem(imageName: "roasters", label: "Roasters", destinationName: "ROASTERS")
					.frame(maxWidth: .infinity)
				Divider()
				NavItem(imageName: "origins", label: "Origins", destinationName: "ORIGINS")
					.frame(maxWidth: .infinity)
				Divider()
				NavItem(imageName: "flavors", label: "Flavors", destinationName: "FLAVORS")
					.frame(maxWidth: .infinity)
			}
			.padding([.leading, .trailing])
			.padding(.top, 0)
			//			Divider()
		}
	}
}

struct Main_Previews: PreviewProvider {
	static var previews: some View {
		ContentView().environmentObject(UserSettings())
	}
}

struct NavItem: View {
	var imageName: String
	var label: String
	var destinationName: String
	@EnvironmentObject var settings: UserSettings
	
	var body: some View {
		VStack{
			Image(imageName).resizable().aspectRatio(contentMode: .fit)
			Text(label)
		}
		.onTapGesture {self.settings.curPage = self.destinationName}
	}
}
