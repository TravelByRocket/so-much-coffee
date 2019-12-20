//
//  MoreTime.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/16/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct MoreTime: View {
    var body: some View {
        HStack {
            Image(systemName: "timer")
            Image(systemName: "timer")
        }.padding()
    }
}

struct MoreTime_Previews: PreviewProvider {
    static var previews: some View {
        MoreTime()
    }
}
