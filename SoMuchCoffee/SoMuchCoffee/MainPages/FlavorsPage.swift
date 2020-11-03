//
//  FlavorsPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/24/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct FlavorsPage: View {
	@State var sheetIsPresented = false
	
	@State private var scale: CGFloat = 1.0
	@State private var dragOffset = CGPoint.zero
	
	var body: some View {
		ZStack {
			Color.white.edgesIgnoringSafeArea(.all)
            FlavorWheel(scale: $scale, dragOffset: $dragOffset)
            VStack {
                Button(action: {self.sheetIsPresented = true} ) {
                    Text("Credit: Counter Culture Coffee")
                        .font(.caption)
                }
                .foregroundColor(.blue)
                
                Spacer()
                
                ZoomControls(scale: $scale, dragOffset: $dragOffset)
                    .padding(.horizontal)
                    .padding(.bottom)
            }
		}
		.sheet(isPresented: $sheetIsPresented) {
			SafariView(url:URL(string: "https://counterculturecoffee.com/learn/resource-center/coffee-tasters-flavor-wheel")!) }
	}
}

struct FlavorsPage_Previews: PreviewProvider {
	static var previews: some View {
		FlavorsPage()
	}
}

struct ZoomControls: View {
    @Binding var scale: CGFloat
    @Binding var dragOffset: CGPoint
    
    var body: some View {
        HStack {
            Slider(value: $scale,
                   in: 1.0 ... 4.0,
                   step: 0.02,
                   minimumValueLabel: Image(systemName: "minus.magnifyingglass").padding([.vertical, .leading]),
                   maximumValueLabel: Image(systemName: "plus.magnifyingglass").padding([.vertical, .trailing]),
                   label: {Text("Zoom Level")})
            
            Button(action: {
                scale = 1.0
                dragOffset = CGPoint.zero
            }) {
                Image(systemName: "arrow.clockwise.circle")
                    .padding(.trailing)
            }
        }
        .foregroundColor(.accentColor)
        .overlay(Capsule()
                    .strokeBorder(Color.accentColor))
    }
}

struct FlavorWheel: View {
    @Binding var scale: CGFloat
    @Binding var dragOffset: CGPoint
    
    var body: some View {
        Image("flavorwheel")
            .resizable()
            .scaleEffect(scale,
                         anchor: .center)
            .simultaneousGesture(DragGesture()
                                    .onChanged{value in
                                        self.dragOffset.x += value.location.x - value.startLocation.x
                                        self.dragOffset.y += value.location.y - value.startLocation.y
                                    }
            )
            .aspectRatio(contentMode: .fit)
            .offset(x: dragOffset.x, y: dragOffset.y)
    }
}
