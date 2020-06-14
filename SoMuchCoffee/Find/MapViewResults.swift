//
//  MapViewList.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 6/14/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI
import MapKit
import RealmSwift

struct MapViewResults: UIViewRepresentable {
	var shops: Results<Shop>
	var centerCoordinate: CLLocationCoordinate2D
	var latitudeDelta: Double
	var longitudeDelta: Double
	var showMarker = true
	var keepMapLocation = false
	
	@EnvironmentObject var mapStatus: MapStatusManager
	
	class Coordinator: NSObject, MKMapViewDelegate {
		var parent: MapViewResults

		init(_ parent: MapViewResults) {
			self.parent = parent
		}
		
		func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
			parent.centerCoordinate = mapView.centerCoordinate
			if parent.keepMapLocation {
				parent.mapStatus.centerCoordinate = mapView.centerCoordinate
				parent.mapStatus.longitudeSpan = mapView.region.span.longitudeDelta
				print("msm will update values for mapState from mapView")
				print("msm centerCoord is \(mapView.centerCoordinate)")
				print("msm the constantly updated center parent.mapStatus.centerCoordinate \(String(describing: parent.mapStatus.centerCoordinate))")
			}
			print("ran mapViewDidChangeVisibleRegion at \(Date())")
//			parent.shops.updateShopsInMapAreaSorted(within: mapView.visibleMapRect, distanceTo: mapView.centerCoordinate)
		}
		
		func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//			print("ran mapView")
			let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
//			if ([annotation isKindOfClass:[MKUserLocation class]])
//			return nil;  //return nil to use default blue dot view
			
//			var view: View
//			if [annotation isKindOfClass:[MKUserLocation class]] {
//				view = nil
//			} else {
//				view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
//			}
			
			view.canShowCallout = true
//			return view
			
			if (annotation is MKUserLocation) {
				return nil
			} else {
				return view
			}
			
		}
		
	}
	
    func makeUIView(context: Context) -> MKMapView {
		print("ran makeUIVew")
        let mapView = MKMapView()
		mapView.delegate = context.coordinator
		mapView.isRotateEnabled = false
		mapView.showsUserLocation = true
//		mapView.userTrackingMode = .follow
		
//		if shops.items.count != mapView.annotations.count {
			for shop in shops {
				let annotation = MKPointAnnotation()
				annotation.title = shop.name
//				annotation.subtitle = "Tasty coffee"
				annotation.coordinate = shop.latlon
				mapView.addAnnotation(annotation)
			}
//		}

		return mapView
    }
	
    func updateUIView(_ view: MKMapView, context: Context) {
		print("ran updateUIVew")
        let coordinate = centerCoordinate
		let span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: false)

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


struct MapViewResults_Previews: PreviewProvider {
    static var previews: some View {
//        MapView()
		Text("no preview yet")
    }
}
