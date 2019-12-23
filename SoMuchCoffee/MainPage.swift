//
//  MainPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/15/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct MainPage: View {
    let menuFontSize: CGFloat = 18
    var body: some View {

        VStack {
            // TITLE
			Spacer()
            Text("So Much Coffee")
                .foregroundColor(Color("appOrange"))
                .font(Font.custom(alfa,size: 40))
			Spacer()
            
            // FIRST ROW
			HStack (alignment: .bottom) {
				NavItem(imageName: "find", itemName: "Find", destinationName: "FIND")
				Divider()
				NavItem(imageName: "brew", itemName: "Brew", destinationName: "BREW")
				Divider()
				NavItem(imageName: "log", itemName: "Log", destinationName: "LOG")
			}
			.padding([.leading, .trailing])
			.padding(.bottom, 0)
			
			Divider()
			
            //SECOND ROW
            HStack (alignment: .bottom) {
				NavItem(imageName: "roasters", itemName: "Roasters", destinationName: "ROASTERS")
				Divider()
				NavItem(imageName: "origins", itemName: "Origins", destinationName: "ORIGINS")
				Divider()
				NavItem(imageName: "flavors", itemName: "Flavors", destinationName: "FLAVORS")
            }
			.padding([.leading, .trailing])
			.padding(.top, 0)
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
	var itemName: String
	var destinationName: String
	@EnvironmentObject var settings: UserSettings
	
	var body: some View {
		VStack{
			Image(imageName).resizable().aspectRatio(contentMode: .fit).padding()
			Text(itemName)
		}
		.onTapGesture {self.settings.curPage = self.destinationName}
	}
}
