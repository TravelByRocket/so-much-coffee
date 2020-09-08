//
//  FontAwesomeIcon.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 4/2/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI
import FontAwesome_swift

/// FA icon as Image, styled to match Image(systemName: "SFSymbolName") and dark-responding
struct FontAwesomeIcon: View {
	let name: FontAwesome
	let type: FontAwesomeStyle
	
	@Environment(\.colorScheme) private var colorScheme
	
	var body: some View {
		Image(uiImage: UIImage.fontAwesomeIcon(
			name: name,
			style: type,
			textColor: colorScheme == .light ? .black : .white,
			size: CGSize(width: 25, height: 25)))
			.padding(2)
			.padding(.leading,-5)
	}
}

struct FontAwesomeIcon_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			Text(String.fontAwesomeIcon(name: .book))
//				.font(.title)
				.font(Font.custom("Font Awesome 5 Free-Solid-900.otf",size: 40))
//			Image(uiImage: UIImage.fontAwesomeIcon(name: <#T##FontAwesome#>, style: <#T##FontAwesomeStyle#>, textColor: <#T##UIColor#>, size: <#T##CGSize#>))
			FontAwesomeIcon(name: .book, type: .solid)
			FontAwesomeIcon(name: .book, type: .solid)
				.environment(\.colorScheme, .dark)
		}
		.previewLayout(.sizeThatFits)
    }
}
