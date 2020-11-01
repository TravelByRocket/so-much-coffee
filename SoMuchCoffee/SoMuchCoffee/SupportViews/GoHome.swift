//
//  GoHome.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/15/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct GoHome: View {
    @EnvironmentObject var settings: UserSettings
    var body: some View {
		Image(systemName: "house")
			.font(.title)
			.onTapGesture {withAnimation{self.settings.curPage = "MAIN"}}
        
    }
}

struct GoHome_Previews: PreviewProvider {
    static var previews: some View {
        GoHome()
    }
}
