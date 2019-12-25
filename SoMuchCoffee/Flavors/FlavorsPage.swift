//
//  FlavorsPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/24/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct FlavorsPage: View {
    var body: some View {
		NavigationView {
			VStack {
				HStack {
					Spacer()
					GoHome().padding().navigationBarTitle("Flavors")
				}
				Spacer()
			}
		}
	}
}

struct FlavorsPage_Previews: PreviewProvider {
    static var previews: some View {
        FlavorsPage()
    }
}
