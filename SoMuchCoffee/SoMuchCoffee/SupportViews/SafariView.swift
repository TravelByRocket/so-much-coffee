//
//  SafariView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/22/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
	
	let url: URL
	
	func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
		return SFSafariViewController(url: url)
	}
	
	func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
		
	}
	
}
