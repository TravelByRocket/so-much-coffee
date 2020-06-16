//
//  DetailRowOnly.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/2/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI
import FontAwesome_swift

struct DetailRowDisplayOnly: View {
	let symbol: String
	let str: String
	
	var body: some View {
		HStack (alignment: .firstTextBaseline){
			Image(systemName: symbol)
			if (str != "") {
				HStack {
					Text(str)
				}
			} else {
				NotAvailableJSON()
			}
		}
	}
}

struct DetailRowDisplayOnlyFA: View {
	let name: FontAwesome
	let type: FontAwesomeStyle
	let str: String
	var noun: String = ""
	
	var body: some View {
		HStack {
			FontAwesomeIcon(name: name, type: type)
			if (str != "") {
				HStack {
					Text(str)
				}
			} else {
				NotAvailableJSON(detail: noun)
			}
		}
	}
}

struct DetailRowOnly_Previews: PreviewProvider {
    static var previews: some View {
		List {
			DetailRowDisplayOnly(symbol: "paperplane.fill", str: "Detail SystemName")
			DetailRowDisplayOnlyFA(name: .book, type: .solid, str: "Detail FA")
		}
    }
}
