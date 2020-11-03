//
//  ShopView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 6/11/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI
import RealmSwift
import MapKit

struct ShopPage: View {
    var shop: Shop
    var showMap: Bool = true
    
    @State private var regionaroundshop = MKCoordinateRegion()
    
    @EnvironmentObject var us: UserSettings
    
    var body: some View {
        GeometryReader {geo in
            VStack {
                if showMap {
                    Map(coordinateRegion: $regionaroundshop, showsUserLocation: true, annotationItems: [shop], annotationContent: { annotation in
                        return MapPin(coordinate: CLLocationCoordinate2D(latitude: shop.latitude, longitude: shop.longitude))
                    })
                    .frame(width: geo.size.width, height: geo.size.height * 2 / 5)
                    .onAppear {
                        regionaroundshop = regionIncluding(shops: [shop])
                    }
                }
                NameTitle(name: shop.name)
                SummaryBlock(summary: shop.summary)
                List {
                    Section (header: Text(
                        shop.roasters.count > 1
                            ? "Featured Roasters"
                            : "Featured Roaster"
                    )) {
                        ForEach (shop.roasters) {roaster in
                            SupplyingRoasterRow(roaster: roaster)
                        }
                    }
                    Section (header: Text("Atmosphere & Features")) {
                        DetailRow(style: .eventsURL, value: shop.eventsURL, entity: shop)
                        DetailRow(style: .beveragesNote, value: shop.beveragesNote, entity: shop)
                        DetailRow(style: .foodNote, value: shop.foodNote, entity: shop)
                        DetailRow(style: .wifiNote, value: shop.wifiNote, entity: shop)
                        DetailRow(style: .powerOutlets, value: shop.powerOutlets, entity: shop)
                        DetailRow(style: .atmosphereSocial, value: shop.atmosphereSocial, entity: shop)
                        DetailRow(style: .atmosphereWork, value: shop.atmosphereWork, entity: shop)
                    }
                    Section (header: Text("Online & Social")) {
                        DetailRow(style: .website, value: shop.website, entity: shop)
                        DetailRow(style: .instagram, value: shop.instagram, entity: shop)
                    }
                    Section (header: Text("Contact")) {
                        DetailRow(style: .address, value: shop.address, entity: shop)
                        DetailRow(style: .phone, value: shop.phone, entity: shop)
                        DetailRow(style: .email, value: shop.email, entity: shop)
                    }
                    Section (header: Text("Other")) {
                        DetailRow(style: .correction, entity: shop)
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}


struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ShopPage(shop: realm.objects(Shop.self).randomElement()!)
                .navigationBarHidden(true)
        }
    }
}

struct SupplyingRoasterRow: View {
    let roaster: Roaster
    var body: some View {
        VStack {
            Text(roaster.name)
                .font(.title3)
            HStack {
                Text("Based in \(roaster.basedIn ?? "")")
                Spacer()
                Text("Location count:")
                Image(systemName: String(roaster.shopsServing.count) + ".circle")
            }
            .foregroundColor(.secondary)
            .font(.caption)
        }
    }
}
