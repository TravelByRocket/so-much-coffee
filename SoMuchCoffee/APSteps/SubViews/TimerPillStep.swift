//
//  TimerPillStep.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/12/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct TimerPillStep: View {
    @Binding var timeElapsedSec: CGFloat
    var timeDurationSec: CGFloat
    
    var body: some View {
        ZStack (alignment: .top){
            Capsule()
                .frame(width: 10, height: 400 * (timeElapsedSec / timeDurationSec))
                .foregroundColor(appOrange)
            Capsule()
                .fill(transparent)
                .frame(width: 10, height: 400)
                .overlay(Capsule().stroke(appDarkGray, lineWidth: 1))
        }.padding(5)
    }
}

struct TimerPillStep_Previews: PreviewProvider {
    @State private static var fakeElapsedTime: CGFloat = 10
    private static let fakeTotalTime: CGFloat = 15
    static var previews: some View {
        TimerPillStep(timeElapsedSec: $fakeElapsedTime, timeDurationSec: fakeTotalTime)
    }
}
