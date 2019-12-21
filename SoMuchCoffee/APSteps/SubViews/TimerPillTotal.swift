//
//  TimerPillTotal.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/12/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct TimerPillTotal: View {
    @Binding var timeElapsedSec: CGFloat
    var timeDurationSec: CGFloat
    
    var body: some View {
        ZStack (alignment: .leading){
            Capsule().frame(width: 20 + 280 * (timeElapsedSec / timeDurationSec), height: 20)
                .foregroundColor(appBlue)
            Capsule().frame(width: 300, height: 20)
                .foregroundColor(transparent)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(appDarkGray).foregroundColor(transparent))
        }
    }
}

struct TimerPillTotal_Previews: PreviewProvider {
    @State private static var fakeElapsedTime: CGFloat = 10
    private static let fakeTotalTime: CGFloat = 15
    static var previews: some View {
        TimerPillTotal(timeElapsedSec: $fakeElapsedTime, timeDurationSec: fakeTotalTime)
    }
}
