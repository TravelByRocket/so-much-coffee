//
//  FindPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/24/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI
import MapKit

struct FindPage: View {
	@EnvironmentObject var allShops: Shops
	@EnvironmentObject var allRoasters: Roasters
	@EnvironmentObject var mapStatus: MapStatusManager
	@ObservedObject var lm = LocationManager()
	
	@State private var locationSource: LocationSource = .shopsCenter
	
	var latitudeDelta: Double {
		return 0.01
//		switch locationSource {
//		case .shopsCenter:
//			return allShops.latitudeDeltaOfShops
//		case .userLocation:
//			if lm.status == .authorizedWhenInUse {
//				return 0.03
//			} else {
//				return 0.20
//			}
//		}
	}
	//	var longitudeDelta: Double {
	//		switch locationSource {
	//		case .shopsCenter:
	//			return allShops.longitudeDeltaOfShops
	//		case .userLocation:
	//			if lm.status == .authorizedWhenInUse {
	//				return 0.03
	//			} else {
	//				return 0.20
	//			}
	//		}
	//	}
	
	var longitudeDelta: Double {
		if let span = mapStatus.longitudeSpanFixed {
			return span
		} else {
			return allShops.longitudeDeltaOfShops
		}
	}
	
	//	var centerCoordinate: CLLocationCoordinate2D {
	//		switch locationSource {
	//		case .shopsCenter:
	//			return allShops.centerOfShops
	//		case .userLocation:
	//			print("lm lat in computed var is \(String(describing: self.lm.location?.coordinate.latitude))")
	//			print("lm lon in computed var is \(String(describing: self.lm.location?.coordinate.longitude))")
	//			return CLLocationCoordinate2D(latitude: (lm.location?.coordinate.latitude) ?? 38, longitude: (lm.location?.coordinate.longitude) ?? 102)
	//		}
	//	}
	
	var centerCoordinate: CLLocationCoordinate2D {
		if let center = mapStatus.centerCoordinateFixed {
			print("msm map center is from mapStatus \(center)")
			return center
		} else {
			print("msm map center is from shops \(allShops.centerOfShops)")
			return allShops.centerOfShops
		}
	}
	
	//	@State private var centerCoordinate2: CLLocationCoordinate2D = allShops.centerOfShops
	
	enum LocationSource {
		case shopsCenter, userLocation
	}
	
	@State private var showList = true
	
//	@GestureState var isDetectingDrag = false
//	@GestureState var isDetectingLongPress = false
//
//	var dragmod: some Gesture {
//		DragGesture()
//			.updating($isDetectingDrag){currentstate, gestureState, transaction in
////				gestureState = currentstate
//				print("isDetectingDrag = \(self.isDetectingDrag)")
//		}
//			.onChanged({ _ in
//				self.mapStatus.allowUpdating = true
//				print("mapStatus.allowUpdating = true via drag")
//			})
//			.onEnded({ finished in
//				self.mapStatus.allowUpdating = false
//				print("mapStatus.allowUpdating = false via drag")
//				print("onEnded \(finished) via drag")
//			})
//	}
//
//	var tapmod: some Gesture {
//		TapGesture()
//			.onEnded({ finished in
//				self.mapStatus.allowUpdating = false
//				print("mapStatus.allowUpdating = false via tap")
//				print("onEnded \(finished) via tap")
//			})
//	}
//
//    var longPress: some Gesture {
//        LongPressGesture(minimumDuration: 3)
//            .updating($isDetectingLongPress) { currentstate, gestureState,
//                    transaction in
//                gestureState = currentstate
//                transaction.animation = Animation.easeIn(duration: 2.0)
//            }
//            .onEnded { finished in
//				print("onEnded \(finished) via longPress")
//            }
//    }
	
	var body: some View {
		NavigationView {
			VStack {
				HStack {
					HStack {
						FontAwesomeIcon(name: .crosshairs, type: .solid)
							.padding(.trailing,-5)
						Text("Center on Me")
					}
					.padding(5)
					.border(Color.primary)
					.background(locationSource == .userLocation ? Color.green : Color.gray)
					.onTapGesture {
						print("lm lat in view var is \(String(describing: self.lm.location?.coordinate.latitude))")
						print("lm lon in view var is \(String(describing: self.lm.location?.coordinate.longitude))")
						self.locationSource = .userLocation
					}
					HStack {
						FontAwesomeIcon(name: .circle, type: .regular)
							.padding(.trailing,-5)
						Text("Center on All")
					}
					.padding(5)
					.border(Color.primary)
					.background(locationSource == .shopsCenter ? Color.green : Color.gray)
					.onTapGesture {
						self.locationSource = .shopsCenter
					}
				}
				ZStack {
					MapView(shops: allShops, centerCoordinate: centerCoordinate, latitudeDelta: 0.01, longitudeDelta: longitudeDelta, keepMapLocation: true)
//						.gesture(tapmod, including: .all)
//						.gesture(dragmod, including: .all)
//						.gesture(longPress, including: .all)
						.edgesIgnoringSafeArea(.bottom)
						.navigationBarTitle("Find a Shop")
						.navigationBarItems(leading: ShowHideList(showList: $showList), trailing: GoHome())
						.onAppear() {
							print("msm incoming coord is \(String(describing: self.mapStatus.centerCoordinateFixed))")
//							print("long coming in is \(String(describing: self.lm.location?.coordinate.longitude))")
					}
						.onDisappear() {
							self.mapStatus.update()
							print("msm map did disappear, called .update()")
					}
					Image(systemName: "smallcircle.circle").opacity(0.7)
				}
				if showList {
					List (allShops.allWithinMapAreaSorted, id: \.shop.id) {shop in
						NavigationLink (destination: ShopView(shop: shop.shop)){
							ShopRow(shop: shop) // location for distance is provided through the Shops class
//							.gesture(TapGesture().onEnded({_ in print("NavLink activated here")}), including: .all)
//													.onTapGesture {
//														print("NavLink activated here")
//													}
						}
//						.gesture(TapGesture().onEnded({_ in print("NavLink activated here")}), including: .all)
//						.onTapGesture {
//							print("NavLink activated here")
//						}
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
				.onTapGesture {
					self.showList.toggle()
			}
			
			Text(showList ? "Hide List" : "Show List")
			Spacer()
		}
		.frame(width: 150)
	}
}


struct FindPage_Previews: PreviewProvider {
	static var previews: some View {
		FindPage()
			.environmentObject(Shops.all)
			.environmentObject(Roasters.all)
			.environmentObject(MapStatusManager())
	}
}

