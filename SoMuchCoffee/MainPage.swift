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
		// NOTE can't figure out how to give the title significantly more space
        VStack {
            // TITLE
			Spacer()
            Text("So Much Coffee")
                .foregroundColor(Color("appOrange"))
                .font(Font.custom(alfa,size: 40))
			Spacer()
            
            // FIRST ROW
			HStack (alignment: .bottom) {
				NavItem(imageName: "find", label: "Find", destinationName: "FIND")
				Divider()
				NavItem(imageName: "brew", label: "Brew", destinationName: "BREW")
				Divider()
				NavItem(imageName: "log", label: "Log", destinationName: "LOG")
			}
			.padding([.leading, .trailing])
			.padding(.bottom, 0)
			
			Divider()
			
            //SECOND ROW
            HStack (alignment: .bottom) {
				NavItem(imageName: "roasters", label: "Roasters", destinationName: "ROASTERS")
				Divider()
				NavItem(imageName: "origins", label: "Origins", destinationName: "ORIGINS")
				Divider()
				NavItem(imageName: "flavors", label: "Flavors", destinationName: "FLAVORS")
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
	var label: String
	var destinationName: String
	@EnvironmentObject var settings: UserSettings
	
	var body: some View {
		VStack{
			Image(imageName).resizable().aspectRatio(contentMode: .fit).padding()
			Text(label)
		}
		.onTapGesture {self.settings.curPage = self.destinationName}
	}
}
