//
//  RealmConfig.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 9/7/20.
//

import Foundation
import RealmSwift

let config = Realm.Configuration(
    // Get the URL to the bundled file
    fileURL: Bundle.main.url(forResource: "default", withExtension: "realm"),
    // Open the file in read-only mode as application bundles are not writeable
    readOnly: false)

// TODO follow Realm guidance on file permission  https://realm.io/docs/swift/latest/#using-the-realm-framework

// Open the Realm with the configuration
let realm = try! Realm(configuration: config)
