//
//  RinseFilterStep.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/16/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RinseFilterStep: View {
    var body: some View {
        HStack {
            Text("Rinse the filter").font(.title).padding()
            Spacer()
        }
        .overlay(RoundedRectangle(cornerRadius: 10)
        .stroke(Color.primary)
        .foregroundColor(Color.clear))
        .padding()
    }
}

struct RinseFilterStep_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            GrindStep()
//            HeatWaterStep()
            RinseFilterStep()
        }
    }
}
