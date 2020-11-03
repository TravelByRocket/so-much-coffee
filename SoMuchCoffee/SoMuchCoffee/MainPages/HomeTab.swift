//
//  HomeTab.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 11/1/20.
//

import SwiftUI

struct HomeTab: View {
    @EnvironmentObject var us: UserSettings
    var body: some View {
        TabView(selection: $us.curTab) {
            FindPage()
                .tabItem {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Shops")
                }
                .tag(Views.shops)
            
            RoastersPage()
                .tabItem {
                    Image(systemName: "flame")
                    Text("Roasters")
                }
                .tag(Views.roasters)
            
            FlavorsPage()
                .tabItem {
                    Image(systemName: "asterisk.circle")
                    Text("Flavors")
                }
                .tag(Views.flavors)
            
            OriginsPage()
                .tabItem {
                    Image(systemName: "globe")
                    Text("Origins")
                }
                .tag(Views.origins)
            
            InfoPage()
                .tabItem {
                    Image(systemName: "info")
                    Text("About")
                }
                .tag(Views.about)
        }
    }
}

struct HomeTab_Previews: PreviewProvider {
    static var previews: some View {
        HomeTab()
            .environmentObject(UserSettings())
    }
}

enum Views {
    case shops, roasters, about, flavors, origins
}
