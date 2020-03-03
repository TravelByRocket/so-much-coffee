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
		super.init(kindOfStep: .installFilter, isCombinable: true)
	}
	
//	override func asViewForList() -> AnyView {
//		return AnyView(
//			Text("Underlined").underline()+Text(" and not underlined"))
//	}
//
//	func asViewForStep() -> AnyView {
//		return AnyView(
//			HStack {
//				Text("Install the filter").font(.title).padding()
//				Spacer()
//			}
//			.overlay(RoundedRectangle(cornerRadius: 10)
//			.stroke(Color.black)
//			.foregroundColor(transparent))
//			.padding()
//		)
//	}
	
	// might an issue with it being a static property of the class because how will it change with each instance? Not applicable for filter install step step but it is for others.
//	struct TestInstallFilterView: View {
//		var body: some View {
//			Text("This is a View in InstallFilter")
//		}
//	}
}

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
		.overlay(RoundedRectangle(cornerRadius: 10)
		.stroke(Color.black)
		.foregroundColor(transparent))
		.padding()
	}
}

struct InstallFilter_Previews: PreviewProvider {
	@State private static var fakeInstallFilter = InstallFilter()
    static var previews: some View {
        List{
			InstallFilterForList()
			InstallFilterForRecipe()
        }
    }
}
