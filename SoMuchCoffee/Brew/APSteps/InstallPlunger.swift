//
//  InstallPlunger.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/2/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct InstallPlungerForList: View {
	var body: some View {
		Text("Install the plunger")
	}
}

struct InstallPlungerForRecipe: View {
	var body: some View {
		HStack {
			Text("Install the plunger").font(.title).padding()
			Spacer()
		}
		.recipeStepContainer()
	}
}

struct InstallPlunger_Previews: PreviewProvider {
    static var previews: some View {
        List{
			InstallPlungerForList()
			InstallPlungerForRecipe()
        }
    }
}
