//
//  PlungeSettings.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/16/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct PlungeSettings: View {
    @State private var duration: Double = 20
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "hare").padding()
                Slider(value: $duration, in: 5...45, step: 1)
                Image(systemName: "tortoise").padding()
            }
            Text("Plunge \(duration, specifier: "%.f") seconds")
        }
    }
}

struct PlungeSettings_Previews: PreviewProvider {
    static var previews: some View {
        PlungeSettings()
    }
}
