//
//  AddWaterStep.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/15/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct AddWaterStep: View {
    @Binding var timeElapsedSec: CGFloat
    var totalTimeSec : CGFloat
    var waterMassG : CGFloat
    
    var body: some View {
        VStack{
            HStack{
                // RESPONSIVE PROGRESS BAR VIEW
                TimerPillStep(timeElapsedSec: $timeElapsedSec, timeDurationSec: totalTimeSec)

                // WAIT STEP CONTENT
                HStack {
                    Spacer()
                    VStack {
                        Text("Pour \(waterMassG, specifier: "%.1f") g water over \(totalTimeSec, specifier: "%.f") seconds").font(.title).padding().fixedSize(horizontal: false, vertical: true)
                            
                        Stopwatch(timeElapsedSec: $timeElapsedSec, timeDurationSec: totalTimeSec).padding()
                        Text("\(waterMassG * (timeElapsedSec / totalTimeSec), specifier: "%.f")").font(Font.custom(monoregular, size: 50)).foregroundColor(Color.blue)
                        Text("grams poured of target \(waterMassG, specifier: "%.f") grams").font(Font.custom(monoregular, size: 15)).foregroundColor(Color.blue).padding(.bottom)
                    }
                    Spacer()
                }
            }
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black).foregroundColor(transparent))
        }.padding()
    }
}

struct AddWaterStep_Previews: PreviewProvider {
    @State private static var fakeElapsedTime: CGFloat = 5
    private static let fakeTotalTime: CGFloat = 9
    private static let fakeWaterMass: CGFloat = 30
    static var previews: some View {
        AddWaterStep(timeElapsedSec: $fakeElapsedTime, totalTimeSec: fakeTotalTime, waterMassG: fakeWaterMass)
    }
}
