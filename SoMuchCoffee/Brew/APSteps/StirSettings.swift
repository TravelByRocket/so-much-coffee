//
//  StirSettings.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/16/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct StirSettings: View {
    @State private var duration: Double = 20
    var body: some View {
        VStack {
            HStack {
                LessTime()
                Slider(value: $duration, in: 5...45, step: 1)
                MoreTime()
            }
            Text("Stir \(duration, specifier: "%.f") seconds")
        }
    }
}

struct StirSettings_Previews: PreviewProvider {
    static var previews: some View {
        StirSettings()
    }
}
