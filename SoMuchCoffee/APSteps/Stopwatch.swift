//
//  Stopwatch.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/13/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct Stopwatch: View {
    @Binding var timeElapsedSec: CGFloat
    var timeDurationSec: CGFloat
    
    var body: some View {
        ZStack{
            Circle()
                .fill(transparent)
                .frame(width:150, height: 150)
                .overlay(Circle().strokeBorder(appDarkGray, style: StrokeStyle(lineWidth: 8, dash: [2,8])))
                .rotationEffect(.degrees(270))
            Circle()
                .fill(transparent)
                .frame(width: 175, height: 175)
                .overlay(Circle().trim(from: 0.0, to: (timeDurationSec / 60)).stroke(appBlue, lineWidth: 8))
                .rotationEffect(.degrees(270))
            Circle()
                .fill(transparent)
                .frame(width:175, height: 175)
                .overlay(Circle().trim(from: 0.0, to: (timeElapsedSec / 60)).stroke(appOrange, lineWidth: 8))
                .rotationEffect(.degrees(270))
            
            VStack {
                ZStack (alignment: .bottomTrailing){
                    Text("0:\(Int(timeDurationSec - timeElapsedSec), specifier: "%02d")").font(Font.custom(monoregular, size: 40))
                    Text(".\((floor(10 * (timeDurationSec - timeElapsedSec))).truncatingRemainder(dividingBy: 10), specifier: "%1.0f")").font(Font.custom(monoregular, size: 12)).offset(x: 9, y: -6).padding(0)
                }.padding(.bottom, -11)
                Text("from 0:\(timeDurationSec, specifier: "%02.f")").font(Font.custom(monoregular, size: 14))
            }
        }
    }
}

//func wholeSeconds (decimalTime: CGFloat) -> String {
//    var numberFormatter = NumberFormatter()
//    numberFormatter.minimumIntegerDigits = 2
//    numberFormatter.string(from: NSNumber(decimalTime))
//}

struct Stopwatch_Previews: PreviewProvider {
    static var previews: some View {
//        Stopwatch()
//        Text("Need to set up Preview for this view")
//        WaitStep()
        Text("placeholder")
    }
}
