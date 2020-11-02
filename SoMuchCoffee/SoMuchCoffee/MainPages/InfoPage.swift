//
//  InfoPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 11/2/20.
//

import SwiftUI

struct InfoPage: View {
    var body: some View {
        VStack {
            Text("So Much Coffee")
                .foregroundColor(Color("AccentColor"))
                .font(Font.custom(Fonts.alfa, size: 40))
                .multilineTextAlignment(.center)
                .padding(.vertical,50)
            Text("This app made from coffee consumed by Bryan Costanza to help you find the best coffee where you are. It's starting in Denver and going everywhere.")
                .multilineTextAlignment(.center)
                .font(.custom(Fonts.mono, size: 18))
                .padding(50)
            Link("Contact me through synodic.co", destination: URL(string: "http://synodic.co")!)
            Spacer()
        }
    }
}

struct InfoPage_Previews: PreviewProvider {
    static var previews: some View {
        InfoPage()
    }
}
