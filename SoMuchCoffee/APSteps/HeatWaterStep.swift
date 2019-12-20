//
//  HeatWaterStep.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/13/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct HeatWaterStep: View {
    var temperature: CGFloat = 165
    var isFahrenheit: Bool = true
    
    var body: some View {
        HStack {
            if isFahrenheit {
                Text("Heat water to \(temperature, specifier: "%.f") °F").font(.title).padding()
            } else {
                Text("Heat water to \(temperature, specifier: "%.1f") °C").font(.title).padding()
            }
            Spacer()
        }
        .overlay(RoundedRectangle(cornerRadius: 10)
        .stroke(Color.black)
        .foregroundColor(transparent))
        .padding()
    }
}


struct HeatWaterStep_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            GrindStep()
            HeatWaterStep()
            RinseFilterStep()
        }
    }
}

