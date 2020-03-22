//
//  ShopRow.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/21/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI
import CoreLocation

struct ShopRow: View {
	@Binding var centerCoordinate: CLLocationCoordinate2D
	let shop: Shop
	
	var body: some View {
		HStack {
			Text("\(shop.kilometersAway(from: self.centerCoordinate), specifier: "%4.1f") km")
				.font(Font.custom(monoregular, size: 15))
				.padding(.vertical, 3)
				.padding(.horizontal, 6)
				.overlay(Capsule()
					.stroke(Color.primary))
			Text(shop.name)
		}
	}
}


//struct ShopRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ShopRow()
//    }
//}
