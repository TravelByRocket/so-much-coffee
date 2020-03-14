//
//  RinseFilter.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/4/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RinseFilterForRecipe: View {
    var body: some View {
        HStack {
            Text("Rinse filter").font(.title).padding()
            Spacer()
        }
		.recipeStepContainer()
    }
}

struct RinseFilterForList: View {
    var body: some View {
        Text("Rinse filter")
    }
}

struct RinseFilter_Previews: PreviewProvider {
    static var previews: some View {
        List{
            RinseFilterForRecipe()
			RinseFilterForList()
        }
    }
}
