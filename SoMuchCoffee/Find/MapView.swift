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
	
	class Coordinator: NSObject, MKMapViewDelegate {
		var parent: MapView

		init(_ parent: MapView) {
			self.parent = parent
		}
		
		func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
			print(mapView.centerCoordinate)
		}
		
		func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
			let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
			view.canShowCallout = true
			return view
		}
		
	}
	
	var center = CLLocationCoordinate2D(latitude: 39.7392, longitude: -104.9903)
	var latlonDelta = 0.1 // 0.1 shows roughly all of Denver
	var showMarker = false
	
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
		mapView.delegate = context.coordinator
		
		for shop in testShops {
			let annotation = MKPointAnnotation()
			annotation.title = shop.name
			annotation.subtitle = "Tasty coffee"
			annotation.coordinate = shop.location
			mapView.addAnnotation(annotation)
		}
		
		// TODO force non-clustering of markers https://stackoverflow.com/questions/48473227/is-it-possible-to-force-mapkit-to-show-all-annotations-without-clustering

		return mapView
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
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
