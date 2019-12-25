//
//  MapView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/24/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
	
	var center = CLLocationCoordinate2D(latitude: 39.7392, longitude: -104.9903)
	var latlonDelta = 0.1 // 0.1 shows roughly all of Denver
	var showMarker = false
	
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
	
    func updateUIView(_ view: MKMapView, context: Context) {
        let coordinate = center
		let span = MKCoordinateSpan(latitudeDelta: latlonDelta, longitudeDelta: latlonDelta)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)

// More MapKit Guides:
// https://www.hackingwithswift.com/example-code/location/adding-places-to-mkmapview-using-mkplacemark
// https://www.hackingwithswift.com/books/ios-swiftui/advanced-mkmapview-with-swiftui
// https://www.hackingwithswift.com/books/ios-swiftui/communicating-with-a-mapkit-coordinator
// https://www.hackingwithswift.com/read/16/2/up-and-running-with-mapkit
		
		if showMarker {
			let place = MKPlacemark(coordinate: center)
			view.addAnnotation(place)
		}
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
