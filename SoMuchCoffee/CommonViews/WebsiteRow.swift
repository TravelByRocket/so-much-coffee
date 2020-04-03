//
//  WebsiteRow.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/2/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct WebsiteRow: View {
	let url: String
	var msg: String = ""
	
	var body: some View {
		DetailRowActionableFA(name: .globe, type: .solid, str: (msg.isEmpty ? url : msg), url: url, rawString: url)
	}
}


struct WebsiteRow_Previews: PreviewProvider {
    static var previews: some View {
		List {
			WebsiteRow(url: "somuchcoffee.com")
			WebsiteRow(url: "somuchcoffee.com", msg: "Override Message")
			WebsiteRow(url: "", msg: "Override Message")
		}
    }
}
