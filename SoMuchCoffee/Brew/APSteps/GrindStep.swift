//
//  GrindStep.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/13/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct GrindStep: View {
    var grinderName: String = "Any Grinder"
    var grindSetting: String = "Medium"
    var beanMass: CGFloat = 15
    
    var body: some View {
        HStack {
            Text("Grind \(beanMass, specifier: "%.1f") g beans with \(grinderName) at \(grindSetting)").font(.title).padding()
            Spacer()
        }
        .overlay(RoundedRectangle(cornerRadius: 10)
        .stroke(Color.black)
        .foregroundColor(transparent))
        .padding()
    }
}

struct GrindStep_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            GrindStep(grinderName: "Rok", grindSetting: "8.5")
            GrindStep()
            HeatWaterStep()
            RinseFilterStep()
        }
        
    }
}
