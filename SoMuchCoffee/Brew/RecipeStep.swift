//
//  RecipeStep.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 2/28/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RecipeStep: Identifiable, Codable {
	var id = UUID()
	var isCombinable: Bool
	var forceAsLastGroupedStep: Bool
	let descriptor: KindOfStep
	
	init(kindOfStep type: KindOfStep, isCombinable: Bool, forceAsLastGroupedStep: Bool = false) {
		self.descriptor = type
		self.isCombinable = isCombinable
		self.forceAsLastGroupedStep = forceAsLastGroupedStep
	}
}

enum KindOfStep {
	// TODO add a steo or otherwise some kind of indication of whether you are running an inverted or upright recipe
	case addWater(seconds: Int, grams: Int)
	case grind(grams: Int) // future need for grinder name or type, setting name or value, maybe more
	case heatWater(tempC: Double?) // nil means "just boil" TODO should be Int? and use `temp: Int?` and `isCelsius: Bool?`
	case installPlunger
	case installFilter // TODO make associated value (isPaper: Bool)
	case plunge(seconds: Int)
	case rinseFilter
	case stir(seconds: Int)
	case wait(seconds: Int)
}

extension KindOfStep: Codable {
	// Mostly following https://medium.com/@hllmandel/codable-enum-with-associated-values-swift-4-e7d75d6f4370
	// Also informed by https://littlebitesofcocoa.com/318-codable-enums
//	enum CodingError: Error { case decoding(String) }
	private enum Base: String, Codable { case addWater, grind, heatWater, installPlunger, installFilter, plunge, rinseFilter, stir, wait }
	private enum CodingKeys: String, CodingKey { case base, addWaterParams, grindParams, heatWaterParams, plungeParams, stirParams, waitParams } // every action in the recipe is CodingKeys.base and then that has an associated enum where each kind of step is represented. For some of those cases it wil also decode parameters specific to that type of step.
	
	private struct addWaterParams: Codable {
		let seconds: Int
		let grams: Int
	}
	
	private struct grindParams: Codable {
		let grams: Int
	}
	
	private struct heatWaterParams: Codable {
		let tempC: Double?
	}
	
	private struct plungeParams: Codable {
		let seconds: Int
	}
	
	private struct stirParams: Codable {
		let seconds: Int
	}
	
	private struct waitParams: Codable {
		let seconds: Int
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let base = try container.decode(Base.self, forKey: .base)
		
		switch base {
			case .addWater:
				let params = try container.decode(addWaterParams.self, forKey: .addWaterParams)
				self = .addWater(seconds: params.seconds, grams: params.grams)
			case .grind:
				let params = try container.decode(grindParams.self, forKey: .grindParams)
				self = .grind(grams: params.grams)
			case .heatWater:
				let params = try container.decode(heatWaterParams.self, forKey: .heatWaterParams)
				self = .heatWater(tempC: params.tempC)
			case .installPlunger:
				self = .installPlunger
			case .installFilter:
				self = .installFilter
			case .plunge:
				let params = try container.decode(plungeParams.self, forKey: .plungeParams)
				self = .plunge(seconds: params.seconds)
			case .rinseFilter:
				self = .rinseFilter
			case .stir:
				let params = try container.decode(stirParams.self, forKey: .stirParams)
				self = .stir(seconds: params.seconds)
			case .wait:
				let params = try container.decode(waitParams.self, forKey: .waitParams)
				self = .wait(seconds: params.seconds)
		}
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		switch self {
			case let .addWater(seconds, grams):
				try container.encode(Base.addWater, forKey: .base)
				try container.encode(addWaterParams(seconds: seconds, grams: grams), forKey: .addWaterParams)
			case let .grind(grams):
				try container.encode(Base.grind, forKey: .base)
				try container.encode(grindParams(grams: grams), forKey: .grindParams)
			case let .heatWater(tempC):
				try container.encode(Base.heatWater, forKey: .base)
				try container.encode(heatWaterParams(tempC: tempC), forKey: .heatWaterParams)
			case .installPlunger:
				try container.encode(Base.installPlunger, forKey: .base)
			case .installFilter:
				try container.encode(Base.installFilter, forKey: .base)
			case let .plunge(seconds):
				try container.encode(Base.plunge, forKey: .base)
				try container.encode(plungeParams(seconds: seconds), forKey: .plungeParams)
			case .rinseFilter:
				try container.encode(Base.rinseFilter, forKey: .base)
			case let .stir(seconds):
				try container.encode(Base.stir, forKey: .base)
				try container.encode(stirParams(seconds: seconds), forKey: .stirParams)
			case let .wait(seconds):
				try container.encode(Base.wait, forKey: .base)
				try container.encode(waitParams(seconds: seconds), forKey: .waitParams)
		}
	}
}
