//
//  WaitSettings.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/16/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct WaitSettings: View {
        @State private var duration: Double = 20
        var body: some View {
            VStack {
                HStack {
                    LessTime()
                    Slider(value: $duration, in: 5...45, step: 1)
                    MoreTime()
                }
                Text("Wait \(duration, specifier: "%.f") seconds")
            }
        }
    }
struct WaitSettings_Previews: PreviewProvider {
    static var previews: some View {
        WaitSettings()
    }
}
