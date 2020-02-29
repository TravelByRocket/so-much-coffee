//
//  InstallFilter.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 2/28/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

class InstallFilter: RecipeStep {
	init() {
		super.init(isCombinable: true)
	}
	
	override func asViewForList() -> AnyView {
		return AnyView(
			Text("Underlined").underline()+Text(" and not underlined"))
	}
	
	func asViewForStep() -> AnyView {
		return AnyView(
			HStack {
				Text("Install the filter").font(.title).padding()
				Spacer()
			}
			.overlay(RoundedRectangle(cornerRadius: 10)
			.stroke(Color.black)
			.foregroundColor(transparent))
			.padding()
		)
	}
}

struct InstallFilter_Previews: PreviewProvider {
	@State private static var fakeInstallFilter = InstallFilter()
    static var previews: some View {
        List{
			fakeInstallFilter.asViewForList()
			fakeInstallFilter.asViewForStep()
        }
    }
}
