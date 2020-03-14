//
//  InstallFilter.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 2/28/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct InstallFilterForList: View {
	var body: some View {
		Text("Install the filter")
	}
}

struct InstallFilterForRecipe: View {
	var body: some View {
		HStack {
			Text("Install the filter").font(.title).padding()
			Spacer()
		}
		.recipeStepContainer()
	}
}

struct InstallFilter_Previews: PreviewProvider {
    static var previews: some View {
        List{
			InstallFilterForList()
			InstallFilterForRecipe()
        }
    }
}
