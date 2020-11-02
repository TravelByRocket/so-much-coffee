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
	let shop: Shop
	let mapCenter: CLLocationCoordinate2D
	
//	@EnvironmentObject private var mapStatus: MapStatusManager

	var body: some View {
		HStack {
			Text("\(shop.kilometersAway(from: mapCenter), specifier: "%4.1f") km")
                .font(.custom(Fonts.mono, size: 15))
				.padding(.vertical, 3)
				.padding(.horizontal, 6)
				.overlay(Capsule()
					.stroke(Color.primary))
			Text(shop.name)
				.lineLimit(1)
		}
	}
}


struct ShopRow_Previews: PreviewProvider {
    static var previews: some View {
		ShopRow(shop: realm.objects(Shop.self).randomElement()!, mapCenter: CLLocationCoordinate2D(latitude: 39.98767, longitude: -105.223802))
//		.environmentObject(MapStatusManager())
    }
}
