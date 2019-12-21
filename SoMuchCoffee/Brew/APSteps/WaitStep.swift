//
//  WaitStep.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/12/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct WaitStep: View {
    @Binding var timeElapsedSec: CGFloat
    var totalTimeSec : CGFloat

    var body: some View {
        VStack{
            HStack{
                // RESPONSIVE PROGRESS BAR VIEW
                TimerPillStep(timeElapsedSec: $timeElapsedSec, timeDurationSec: totalTimeSec)
                Spacer()
                // WAIT STEP CONTENT
                VStack {
                    Text("Wait for \(Int(totalTimeSec), specifier: "%d") seconds").font(.title).padding()
                    Stopwatch(timeElapsedSec: $timeElapsedSec, timeDurationSec: totalTimeSec).padding()
                }
                Spacer()
            }
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black).foregroundColor(transparent))
        }.padding()
    }
}

struct WaitStep_Previews: PreviewProvider {
    @State private static var fakeElapsedTime: CGFloat = 5
    private static let fakeTotalTime: CGFloat = 9
    static var previews: some View {
        WaitStep(timeElapsedSec: $fakeElapsedTime, totalTimeSec: fakeTotalTime)
    }
}
