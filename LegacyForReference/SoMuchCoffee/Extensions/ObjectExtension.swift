//
//  ObjectExtension.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 6/16/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import Foundation
import RealmSwift

protocol Reportable {
	var id: String { get }
	var name: String { get }
}
