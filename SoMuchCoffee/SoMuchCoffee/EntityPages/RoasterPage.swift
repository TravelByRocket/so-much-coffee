//
//  RoasterView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 6/11/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI
import RealmSwift
import MapKit

struct RoasterPage: View {
	var roaster: Roaster
    var showMap: Bool = true
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion()
    
    @EnvironmentObject var us: UserSettings
    
    var body: some View {
        GeometryReader {geo in
            VStack {
                if showMap {
                    Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: roaster.shopsServing,
                        annotationContent: { annotation in
                            return MapPin(coordinate: CLLocationCoordinate2D(latitude: annotation.latitude, longitude: annotation.longitude))
                        })
                        .frame(width: geo.size.width, height: geo.size.height * 2 / 5)
                        .onAppear{
                            region = regionIncluding(shops: Array(roaster.shopsServing))
                    }
                }
                NameTitle(name: roaster.name)
                SummaryBlock(summary: roaster.summary)
                List {
                    Section (header: Text("Locations Serving")) {
                        ForEach (roaster.shopsServing.sorted(byKeyPath: "name")) {shop in
                            NavigationLink(destination: ShopPage(shop: shop)) {
                                HStack {
                                    Image(systemName: shop.affiliatedRoaster != nil ? "link.circle.fill" : "smallcircle.fill.circle")
                                    Text(shop.name)
                                }
                            }
                        }
                    }
                    Section (header: Text("More Details")){
                        DetailRow(style: .instagram, value: roaster.instagram, entity: roaster)
                        
                        HStack {
                            Image(systemName: "equal.circle.fill")
                            Text("Fair Trade: \(fairTradeString())")
                        }
                        
                        DetailRow(style: .offerDetails, value: roaster.offerDetails, entity: roaster)
                        DetailRow(style: .offerCode, value: roaster.offerCode, entity: roaster)
                        
                        DetailRow(style: .orderURL, value: roaster.orderingURL, entity: roaster)
                        DetailRow(style: .subscribeURL, value: roaster.subscriptionURL, entity: roaster)
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
	
	func fairTradeString() -> String {
		if (roaster.isFairtrade.value == nil) {
			return "Unknown"
		} else if (roaster.isFairtrade.value == true) {
			return "Yes"
		} else {
			return "No"
		}
	}
}

struct RoasterView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			RoasterPage(roaster: realm.objects(Roaster.self).randomElement()!)
		}
		.navigationBarTitle("Shop Name")
    }
}
