//
//  MainPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/15/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI
import RealmSwift

struct MainPage: View {
	@State private var showAbout = false
	@EnvironmentObject var mapStatus: MapStatusManager
	
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
			
			Text("\(realm.objects(Shop.self).count) shops found")
			
			// FIRST ROW
			HStack (alignment: .bottom) {
				NavItem(imageName: "find", label: "Shops", destinationName: "FIND")
				Divider()
				NavItem(imageName: "roasters", label: "Roasters", destinationName: "ROASTERS")
			}
			.padding(.bottom, 0)
			
			Divider()
			
			//SECOND ROW
			HStack (alignment: .bottom) {
				NavItem(imageName: "calendar", label: "Events", destinationName: "EVENTS", isSystemName: true)
				Divider()
				NavItem(imageName: "origins", label: "Origins", destinationName: "ORIGINS")
				Divider()
				NavItem(imageName: "flavors", label: "Flavors", destinationName: "FLAVORS")
			}
			.padding(.top, 0)
		}
		.padding(.horizontal)
		.onAppear() {
			self.mapStatus.reset()
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
	var isSystemName = false
	
	@EnvironmentObject var settings: UserSettings
	
	var body: some View {
		VStack{
			if !isSystemName {
				Image(imageName)
				.resizable()
				.aspectRatio(contentMode: .fit)
			} else {
				Image(systemName: imageName)
				.resizable()
				.aspectRatio(contentMode: .fit)
			}
			Text(label)
		}
		.onTapGesture {
			withAnimation() {
				self.settings.curPage = self.destinationName
			}
		}
		.frame(maxWidth: .infinity)
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
