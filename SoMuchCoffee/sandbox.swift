//
//  sandbox.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 6/14/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI
import RealmSwift

struct sandbox: View {
    var body: some View {
		woodchips(collection: realm.objects(Roaster.self))
    }
}

struct woodchips<T: RealmCollection>: View {
	var collection: T
    var body: some View {
		Text(String(collection.count))
    }
}

struct sandbox_Previews: PreviewProvider {
    static var previews: some View {
        sandbox()
    }
}
