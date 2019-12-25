//
//  MapShops.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/24/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI
import MapKit

struct MapShops: UIViewRepresentable {
	@Binding var shops: [Shop]
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
	
    func updateUIView(_ view: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: 39.7392, longitude: -104.9903)
		let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}

struct MapShops_Previews: PreviewProvider {
	@State static var shops: [Shop] = testShops
    static var previews: some View {
		MapShops(shops: $shops)
    }
}
