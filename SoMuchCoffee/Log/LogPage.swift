//
//  LogPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/24/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct LogPage: View {
    var body: some View {
		NavigationView {
			VStack {
				Spacer()
				Text("Under development")
				Spacer()
			}
			.navigationBarTitle("Log")
			.navigationBarItems(trailing: GoHome())
		}
    }
}

struct LogPage_Previews: PreviewProvider {
    static var previews: some View {
        LogPage()
    }
}
