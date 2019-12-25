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
		NavigationView {
			VStack {
				HStack {
					Spacer()
					GoHome().padding()
				}
				MapShops(shops: $shops)
					.navigationBarTitle("Find a Shop")
				List {
					ForEach (shops) {shop in
						NavigationLink (destination: ShopView(shop: shop)){
							Text(shop.name)
						}
						
					}
				}
			}
		}
    }
}

struct FindPage_Previews: PreviewProvider {
    static var previews: some View {
        FindPage()
    }
}
