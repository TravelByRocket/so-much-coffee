//
//  SoMuchCoffeeApp.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 9/7/20.
//

import SwiftUI

@main
struct SoMuchCoffeeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserSettings())
        }
    }
}
