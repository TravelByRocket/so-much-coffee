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
	var shopContainer: Shops
	var centerCoordinate: CLLocationCoordinate2D
	var latlonDelta = 0.1 // 0.1 shows roughly all of Denver
	var showMarker = true
	
	class Coordinator: NSObject, MKMapViewDelegate {
		var parent: MapView

		init(_ parent: MapView) {
			self.parent = parent
		}
		
		func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
			parent.centerCoordinate = mapView.centerCoordinate
			parent.shopContainer.updateShopsInMapAreaSorted(within: mapView.visibleMapRect, distanceTo: mapView.centerCoordinate)
		}
		
		func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
			print("ran mapView")
			let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
			view.canShowCallout = true
			return view
		}
		
	}
	
    func makeUIView(context: Context) -> MKMapView {
		print("ran makeUIVew")
        let mapView = MKMapView()
		mapView.delegate = context.coordinator
		
		if shopContainer.items.count != mapView.annotations.count {
			for shop in shopContainer.items {
				let annotation = MKPointAnnotation()
				annotation.title = shop.name
//				annotation.subtitle = "Tasty coffee"
				annotation.coordinate = shop.latlon
				mapView.addAnnotation(annotation)
			}
		}

		return mapView
    }
	
    func updateUIView(_ view: MKMapView, context: Context) {
		print("ran updateUIVew")
        let coordinate = centerCoordinate
		let span = MKCoordinateSpan(latitudeDelta: latlonDelta, longitudeDelta: latlonDelta)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)

// More MapKit Guides:
// https://www.hackingwithswift.com/example-code/location/adding-places-to-mkmapview-using-mkplacemark
// https://www.hackingwithswift.com/books/ios-swiftui/advanced-mkmapview-with-swiftui
// https://www.hackingwithswift.com/books/ios-swiftui/communicating-with-a-mapkit-coordinator
// https://www.hackingwithswift.com/read/16/2/up-and-running-with-mapkit

    }
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
