//
//  HeatWaterSettings.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/16/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct HeatWaterSettings: View {
    @State private var units = ["°F","°C","Simple Boil"]
    @State private var selectedTemp = 0
    @State private var selectedUnit = 0
    
    @State private var tempF: Double = 165
    @State private var tempC: Double = 74
    
    var body: some View {
        VStack {
            Picker(selection: $selectedUnit, label: Text("Select a unit")) {
                ForEach(0 ..< units.count) {
                    Text(self.units[$0]).tag($0)
                }
            }.pickerStyle(SegmentedPickerStyle())

//            Picker(selection: $selectedTemp, label: Text("Please choose a temperature")) {
//                ForEach(150..<180) {
//                    Text("\($0)")
//                }
//            }
            
            VStack {
                if selectedUnit == 0 {
                    HStack{
                        CoolerTemp()
                        Slider(value: $tempF, in: 150...212, step: 1)
                        WarmerTemp()
                    }
                    Text("Temp selected is \(tempF, specifier: "%.f")")
                } else if selectedUnit == 1 {
                    HStack{
                        CoolerTemp()
                        Slider(value: $tempC, in: 65...100, step: 0.5)
                        WarmerTemp()
                    }
                    Text("Temp selected is \(tempC, specifier: "%.1f")")
                } else if selectedUnit == 2 {
                    HStack {
                        Text("Easy. Boil that water, you maniac.")
                    }
                }
                
            }
        }
    }
}

struct HeatWaterSettings_Previews: PreviewProvider {
    static var previews: some View {
        HeatWaterSettings()
    }
}

struct CoolerTemp: View {
    var body: some View {
        Image(systemName: "thermometer").padding()
    }
}

struct WarmerTemp: View {
    var body: some View {
        HStack {
            Image(systemName: "thermometer")
            Image(systemName: "thermometer")
        }.padding()
    }
}
