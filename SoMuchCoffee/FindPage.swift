//
//  FindPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/24/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct FindPage: View {
	@State private var shops: [Shop] = testShops
    var body: some View {
		VStack {
			Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
			MapShops(shops: $shops)
		}
    }
}

struct FindPage_Previews: PreviewProvider {
    static var previews: some View {
        FindPage()
    }
}
