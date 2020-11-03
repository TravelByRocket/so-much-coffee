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
    private var shops = realm.objects(Shop.self)
    
    @State private var region = regionIncluding(shops: Array(realm.objects(Shop.self)))
//    @State private var isMapCompact = false
    
    var body: some View {
        GeometryReader {geo in
        NavigationView {
            VStack {
                    ZStack {
                        Map(coordinateRegion: $region,
                            showsUserLocation: true,
                            annotationItems: shops,
                            annotationContent: { annotation in
                                return MapPin(coordinate: CLLocationCoordinate2D(latitude: annotation.latitude, longitude: annotation.longitude))
                            })
                            .edgesIgnoringSafeArea(.top)
                            .navigationBarHidden(true)
                        Image(systemName: "smallcircle.circle")
                            .opacity(0.7)
                            .allowsHitTesting(false)
                        VStack {
                            Text("So Much Coffee")
                                .foregroundColor(Color("AccentColor"))
                                .font(Font.custom(Fonts.alfa, size: 40))
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        .allowsHitTesting(false)
                    }
                    .frame(width: geo.size.width, height: geo.size.height / 2)
                    ShopsInMapSorted(region: $region, shops: shops)
                }
                .animation(.default)
            }
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

func regionIncluding(shops: [Shop], bufferFactor: Double = 1.2) -> MKCoordinateRegion {
    
    let center = CLLocationCoordinate2D(
        latitude: shops.centerCoordinate.latitude,
        longitude: shops.centerCoordinate.longitude)
    
    let latitudeDelta = shops.latitudeDelta * bufferFactor
    let longitudeDelta = shops.longitudeDelta * bufferFactor
    let minDelta = 0.02 // single-item maps are too zoomed in without this
    let span = MKCoordinateSpan(
        latitudeDelta: max(latitudeDelta,minDelta),
        longitudeDelta: max(longitudeDelta,minDelta))
    
    let region = MKCoordinateRegion(center: center, span: span)
    
    return region
}

struct FindPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FindPage()
        }
    }
}

struct ShopsInMapSorted: View {
    @Binding var region: MKCoordinateRegion
    let shops: Results<Shop>
    
    var body: some View {
        List{
            Section(header: Text("Shops by Distance to Center")) {
                ForEach(Array(shops).filter({$0.isInMap(region)})
                            .sorted( by: { $0.kilometersAway(from: region.center) < $1.kilometersAway(from: region.center) } )
                ) { shop in
                    NavigationLink (destination: ShopPage(shop: shop)){
                            ShopRow(shop: shop, mapCenter: region.center)
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
    }
}
