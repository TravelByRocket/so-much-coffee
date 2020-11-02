//
//  MainPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/15/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI
import RealmSwift

struct HomePage: View {
	var body: some View {
		VStack {
            Spacer()
            Spacer()
            Text("So Much Coffee")
                .foregroundColor(Color("AccentColor"))
                .font(Font.custom(Fonts.alfa, size: 40))
                .multilineTextAlignment(.center)
            Spacer()
			HStack (alignment: .bottom) {
				NavItem(imageName: "find", label: "Shops", destinationName: "FIND")
                    .padding()
                NavItem(imageName: "roasters", label: "Roasters", destinationName: "ROASTERS")
                    .padding()
			}
            Spacer()
		}
		.padding(.horizontal)
	}
}

struct Main_Previews: PreviewProvider {
	static var previews: some View {
		HomePage()
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
                .font(.title)
		}
		.onTapGesture {
			withAnimation() {
				self.settings.curPage = self.destinationName
			}
		}
		.frame(maxWidth: .infinity)
	}
}
