//
//  InstallFilterStep.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/18/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct InstallFilterStep: View {
    var body: some View {
        HStack {
            Text("Install the filter").font(.title).padding()
            Spacer()
        }
        .overlay(RoundedRectangle(cornerRadius: 10)
        .stroke(Color.black)
        .foregroundColor(transparent))
        .padding()
    }
}

struct InstallFilterStep_Previews: PreviewProvider {
    static var previews: some View {
        InstallFilterStep()
    }
}
