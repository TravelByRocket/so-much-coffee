//
//  ContentView.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/9/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

//var appOrange:    Color = Color.init(red: 1.00, green: 0.34, blue: 0.13)
var appOrange50:  Color = Color.init(red: 1.00, green: 0.67, blue: 0.26)
var appBlue:      Color = Color.init(red: 0.26, green: 0.52, blue: 0.97)
var appDarkGray:  Color = Color.init(red: 0.66, green: 0.66, blue: 0.66)
var appLightGray: Color = Color.init(red: 0.90, green: 0.90, blue: 0.90)
var transparent:  Color = Color.init(red: 0.00, green: 0.00, blue: 0.00, opacity: 0.00)
let alfa: String = "AlfaSlabOne-Regular"
let lato: String = "Lato-Light"
let monoregular: String = "B12Mono-Regular"
let monobold: String = "B12Mono-Bold"
let timerInterval: CGFloat = 0.05

struct ContentView: View {
	@EnvironmentObject var settings: UserSettings
	@EnvironmentObject var allShops: Shops
	
	var body: some View {
		
		VStack{
			if settings.curPage == "MAIN" {
				MainPage()
			} else if settings.curPage == "FIND" {
				FindPage()
			} else if settings.curPage == "ROASTERS" {
				RoastersPage()
			} else if settings.curPage == "ORIGINS" {
				CoffeesPage()
			} else if settings.curPage == "FLAVORS" {
				FlavorsPage()
			} else if settings.curPage == "EVENTS" {
				EventsPage()
			}
		}
	}
	
	//	enum Pages {
	//		case main, shops, roasters, origins, flavors
	//	}
	
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView().environmentObject(UserSettings())
	}
}

class UserSettings: ObservableObject {
	@Published var curPage = "MAIN"
}

extension Color {
	static let appOrange = Color("appOrange")
}

// https://www.hackingwithswift.com/example-code/system/how-to-decode-json-from-your-app-bundle-the-easy-way
extension Bundle {
	func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
		guard let url = self.url(forResource: file, withExtension: nil) else {
			fatalError("Failed to locate \(file) in bundle.")
		}
		
		guard let data = try? Data(contentsOf: url) else {
			fatalError("Failed to load \(file) from bundle.")
		}
		
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = dateDecodingStrategy
		decoder.keyDecodingStrategy = keyDecodingStrategy
		
		do {
			return try decoder.decode(T.self, from: data)
		} catch DecodingError.keyNotFound(let key, let context) {
			fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
		} catch DecodingError.typeMismatch(_, let context) {
			fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
		} catch DecodingError.valueNotFound(let type, let context) {
			fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
		} catch DecodingError.dataCorrupted(_) {
			fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
		} catch {
			fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
		}
	}
}

func getDocumentsDirectory() -> URL {
	// find all possible documents directories for this user
	let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
	
	// just send back the first one, which ought to be the only one
	return paths[0]
}
