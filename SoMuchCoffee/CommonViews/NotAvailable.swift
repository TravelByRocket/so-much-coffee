//
//  NotAvailable.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/2/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct NotAvailable: View {
	var detail: String = ""
	@EnvironmentObject private var currentShop: ReportingShop
	var body: some View {
		Text("No \(detail != "" ? detail + " " : detail)info. Click to provide details.")
			.italic()
			.foregroundColor(Color.secondary)
			.onTapGesture {
				sendEmail(addr: "app@somuchcoffee.co?subject=Correction%20for%20Shop%20%22\(self.currentShop.shop!.id)%22")
		}
	}
}

struct NotAvailable_Previews: PreviewProvider {
    static var previews: some View {
		NotAvailable()
    }
}
