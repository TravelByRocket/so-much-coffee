//
//  DismissToPopover.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/4/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct DismissToPopover: View {
	@Binding var activeOption: Bool
	var body: some View {
		Text("Dismiss").foregroundColor(Color.blue)
			.padding()
			.onTapGesture {
				self.activeOption = false
		}
	}
}

struct DismissToPopover_Previews: PreviewProvider {
	@State static private var fakeShowOptions: Bool = true
	static var previews: some View {
		DismissToPopover(activeOption: $fakeShowOptions)
    }
}
