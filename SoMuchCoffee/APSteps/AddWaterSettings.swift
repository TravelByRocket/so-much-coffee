//
//  AddWaterSettings.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/16/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct AddWaterSettings: View {
    @State private var duration: Double = 20
    @State private var mass: Double = 30
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "eyedropper").padding()
                Slider(value: $mass, in: 5...45, step: 1)
                Image(systemName: "eyedropper.full").padding()
            }
            Text("Pour \(mass, specifier: "%.f") grams of water")
            HStack {
                Image(systemName: "hare").padding()
                Slider(value: $duration, in: 5...45, step: 1)
                Image(systemName: "tortoise").padding()
            }
            Text("over \(duration, specifier: "%.f") seconds")
        }
    }
}

struct AddWaterSettings_Previews: PreviewProvider {
    static var previews: some View {
        AddWaterSettings()
    }
}
