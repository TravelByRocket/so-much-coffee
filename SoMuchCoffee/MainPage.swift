//
//  MainPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/15/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct MainPage: View {
	@State private var showAbout = false
	
	var body: some View {
		VStack {
			// TITLE
			ZStack {
				TitleView()
				AppInfoButton(showAbout: $showAbout)
			}
			.sheet(isPresented: $showAbout) {
				AboutPage()
			}
			
			// FIRST ROW
			HStack (alignment: .bottom) {
				NavItem(imageName: "find", label: "Shops", destinationName: "FIND")
					.frame(maxWidth: .infinity)
				Divider()
				NavItem(imageName: "roasters", label: "Roasters", destinationName: "ROASTERS")
					.frame(maxWidth: .infinity)
			}
			.padding(.bottom, 0)
			
			Divider()
			
			//SECOND ROW
			HStack (alignment: .bottom) {
				VStack {
					Image(systemName: "calendar")
						.resizable()
						.aspectRatio(contentMode: .fit)
					Text("Events")
				}
				.foregroundColor(Color.gray.opacity(0.6))
				.frame(maxWidth: .infinity)
				Divider()
				NavItem(imageName: "origins", label: "Origins", destinationName: "ORIGINS")
					.frame(maxWidth: .infinity)
				Divider()
				NavItem(imageName: "flavors", label: "Flavors", destinationName: "FLAVORS")
					.frame(maxWidth: .infinity)
			}
			.padding(.top, 0)
		}
		.padding(.horizontal)
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
		.onTapGesture {
			withAnimation() {
				self.settings.curPage = self.destinationName
			}
		}
	}
}

struct AppInfoButton: View {
	@Binding var showAbout: Bool
	var body: some View {
		HStack {
			Spacer()
			VStack {
				Image(systemName: "info.circle")
					.foregroundColor(Color.blue)
					.padding()
					.onTapGesture {
						self.showAbout = true
				}
				Spacer()
			}
		}
	}
}

struct TitleView: View {
	var body: some View {
		Text("So Much Coffee")
			.foregroundColor(Color("appOrange"))
			.font(Font.custom(alfa,size: 40))
			.multilineTextAlignment(.center)
			.frame(maxHeight: .infinity)
	}
}

struct AboutPage: View {
	var body: some View {
		VStack (alignment: .center, spacing: 10){
			Text("This app was made by Bryan Costanza")
		}
	}
}
