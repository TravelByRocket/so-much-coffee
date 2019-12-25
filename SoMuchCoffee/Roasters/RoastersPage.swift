//
//  RoastersPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/24/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RoastersPage: View {
    var body: some View {
		NavigationView {
			VStack {
				HStack {
					Spacer()
					GoHome().padding().navigationBarTitle("Roasters")
				}
				List {
					Text("Coda")
					Text("Huckleberry")
					Text("Metropolis")
					Text("Fourtillfour")
					Text("Middle State")
					Text("Ozo")
					Text("Color")
				}
				Spacer()
			}
		}
    }
}

struct RoastersPage_Previews: PreviewProvider {
    static var previews: some View {
        RoastersPage()
    }
}
