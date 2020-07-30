//
//  FindPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 6/14/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI
import MapKit
import RealmSwift

struct FindPage: View {
	var shops = realm.objects(Shop.self)
	let eventShops = realm.objects(Shop.self).filter("eventsURL CONTAINS 'http'")
	
	@State private var region = regionForAllShops()
	@ObservedObject private var lm = LocationManager()
	
	@State private var locationSource: LocationSource = .userLocation
	@State private var onlyShowEvents = false
	
	enum LocationSource {
		case shopsCenter, userLocation
	}
	
	@State private var showList = true
	
	var body: some View {
		return NavigationView {
			VStack {
				ZStack {
					Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: onlyShowEvents ? eventShops : shops,
						annotationContent: { annotation in
							return MapPin(coordinate: CLLocationCoordinate2D(latitude: annotation.latitude, longitude: annotation.longitude))
						})
						.edgesIgnoringSafeArea(.bottom)
						.navigationBarTitle("Find a Shop")
						.navigationBarItems(trailing: GoHome())
					//						.navigationBarItems(leading: ShowHideList(showList: $showList), trailing: GoHome()) // TODO showing list zooms map out trying to maintain max of latitude
					Image(systemName: "smallcircle.circle").opacity(0.7)
					HStack{
						Spacer()
						VStack{
							Button(action: {
								region = regionForAllShops()
							}, label: {
								Image(systemName: "location")
									.padding()
							})
							Spacer()
						}
					}
				}
				if showList {
					List{
						Toggle("Only Locations with Events", isOn: $onlyShowEvents)
						ForEach(Array(onlyShowEvents ? eventShops : shops).filter({$0.isInMap(region)}).sorted( by: { $0.kilometersAway(from: region.center) < $1.kilometersAway(from: region.center) } )) { shop in
							NavigationLink (destination: ShopPage(shop: shop)){
								VStack {
									ShopRow(shop: shop, mapCenter: region.center)
								}
							}
						}
					}
				}
			}
			.animation(.default)
		}
	}
}

struct ShowHideList: View {
	@Binding var showList: Bool
	
	var body: some View {
		HStack {
			Image(systemName: showList ? "arrow.down.square" : "arrow.up.square")
			Text(showList ? "Hide List" : "Show List")
			Spacer()
		}
		.frame(width: 200)
		.onTapGesture {
			self.showList.toggle()
		}
	}
}

fileprivate func regionForAllShops() -> MKCoordinateRegion {
	let shops = realm.objects(Shop.self)
	let bufferFactor = 1.2
	return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: shops.centerCoordinate.latitude, longitude: shops.centerCoordinate.longitude), span: MKCoordinateSpan(latitudeDelta: shops.latitudeDelta * bufferFactor, longitudeDelta: shops.longitudeDelta * bufferFactor))
}

struct FindPage_Previews: PreviewProvider {
	static var previews: some View {
		FindPage()
	}
}
