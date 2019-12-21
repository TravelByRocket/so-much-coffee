//
//  GrindSettings.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/16/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct GrindSettings: View {

    @State private var selectedGrindType = 0
    @State private var grindTypes = ["Qualitative", "Numerical"]
    
    @State private var selectedGrindLevel = 0
    @State private var grindLevelQualitative = ["Extra Fine", "Fine", "Medium-Fine", "Medium", "Medium-Coarse", "Coarse","Fine"]
                                                
    @State private var selectedGrinder = 0
    @State private var grinders = ["Generic", "Rok", "Vario"]
     
    var body: some View {
        VStack {
//            Text("Grind Settings")
//                .font(.title)
            Form {
                Picker(selection: $selectedGrindType, label: Text("Select a grind setting type")) {
                    ForEach(0 ..< grindTypes.count) {
                        Text(self.grindTypes[$0]).tag($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                Picker(selection: $selectedGrinder, label: Text("Select a grinder")) {
                    ForEach(0 ..< grinders.count) {
                        Text(self.grinders[$0]).tag($0)
                    }
                }
                if grindTypes[selectedGrindType] == "Qualitative" {
                    Picker(selection: $selectedGrindLevel, label: Text("Select a grind level")) {
                        ForEach(0 ..< grindLevelQualitative.count) {
                            Text(self.grindLevelQualitative[$0]).tag($0)
                        }
                    }
                } else if grindTypes[selectedGrindType] == "Numerical" {
                    Text("Pick approprate number for given grinder (needs more logic programmed)")
                }
            }
        }
    }
}

struct GrindSettings_Previews: PreviewProvider {
    static var previews: some View {
        GrindSettings()
    }
}
