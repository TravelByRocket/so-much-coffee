//
//  AddButton.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/10/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct AddButton: View {
    @State var isEnabled: Bool = true
    var body: some View {
        Text("+")
            .font(.system(size: 40))
            .foregroundColor(Color.black)
            .padding()
            .background(isEnabled ? appOrange50 : appLightGray)
//            .background(appOrange50)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.black, lineWidth: 1))
//        Text(isEnabled ? "it is true" : "it is false")
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        
//        AddButton()
        VStack{
            AddButton()
            AddButton(isEnabled: true)
            AddButton(isEnabled: false)
        }
        
    }
}
