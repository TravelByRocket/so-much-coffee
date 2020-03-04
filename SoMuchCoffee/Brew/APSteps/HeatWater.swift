//
//  HeatWater.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/3/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct HeatWaterForSettings: View {
	@Binding var recipe: Recipe // NOTE this should probably be environment object
	@Binding var showPopover: Bool
	@Binding var showSettings: Bool
	
    @State private var units = ["°F","°C","Simple Boil"]
    @State private var selectedTemp = 0
    @State private var selectedUnit = 0
    
    @State private var tempF: Double = 165
    @State private var tempC: Double = 74
    
    var body: some View {
        VStack {
            Picker(selection: $selectedUnit, label: Text("Select a unit")) {
                ForEach(0 ..< units.count) {
                    Text(self.units[$0]).tag($0)
                }
            }.pickerStyle(SegmentedPickerStyle())
            VStack {
                if selectedUnit == 0 {
                    HStack{
                        CoolerTemp()
                        Slider(value: $tempF, in: 150...212, step: 1)
                        WarmerTemp()
                    }
                    Text("Temp selected is \(tempF, specifier: "%.f")")
                } else if selectedUnit == 1 {
                    HStack{
                        CoolerTemp()
                        Slider(value: $tempC, in: 65...100, step: 1)
                        WarmerTemp()
                    }
                    Text("Temp selected is \(tempC, specifier: "%.f")")
                } else if selectedUnit == 2 {
                    HStack {
                        Text("Easy. Boil that water, you maniac.")
                    }
                }
            }
			addToRecipe()
        }
    }
	
	func addToRecipe() -> AnyView{
		var forExportTempC: Double? = nil
		switch self.selectedUnit {
			case 0:
				forExportTempC = (self.tempF - 32) * 5 / 9
			case 1:
				forExportTempC = self.tempC
			case 2:
				forExportTempC = nil
			default:
				forExportTempC = nil
		}
		return AnyView(
			Button(action:
				{	self.recipe.steps.append(RecipeStep(kindOfStep: .heatWater(tempC: forExportTempC), isCombinable: true))
					self.showPopover = false
					self.showSettings = false
			}) { Text("Add to Recipe") }
		)
	}
}

struct HeatWaterForList: View {
	var tempC: Double?
	
	var body: some View {
		VStack{
			if hasTempValue(temp: tempC) {
				Text("Heat water to \(tempC!, specifier: "%.f") °C")
			} else {
				Text("Boil the water")
			}
		}
	}
	
	func hasTempValue(temp value: Double?) -> Bool {
		if value != nil {
			return true
		} else {
			return false
		}
	}
}

struct HeatWaterForRecipe: View {
    var tempC: Double?
    
    var body: some View {
		HStack{
			if hasTempValue(temp: tempC) {
				Text("Heat water to \(tempC!, specifier: "%.f") °F").font(.title).padding()
			} else {
				Text("Boil the water").font(.title).padding()
			}
		}
        .overlay(RoundedRectangle(cornerRadius: 10)
        .stroke(Color.primary)
        .foregroundColor(Color.clear))
        .padding()

    }
	
	func hasTempValue(temp value: Double?) -> Bool {
		if value != nil {
			return true
		} else {
			return false
		}
	}
}


struct CoolerTemp: View {
	var body: some View {
		Image(systemName: "thermometer").padding()
	}
}

struct WarmerTemp: View {
	var body: some View {
		HStack {
			Image(systemName: "thermometer")
			Image(systemName: "thermometer")
		}.padding()
	}
}

	
struct HeatWater_Previews: PreviewProvider {
	@State private static var fakeRecipe = Recipe(name: "FakeRecipe")
	@State private static var fakeShowPopover = true
	@State private static var fakeShowSettings = true
    static var previews: some View {
        VStack{
			List{
				HeatWaterForSettings(recipe: $fakeRecipe, showPopover: $fakeShowPopover, showSettings: $fakeShowSettings)
				HeatWaterForList(tempC: 80)
				HeatWaterForList(tempC: nil)
				HeatWaterForRecipe(tempC: 80)
				HeatWaterForRecipe(tempC: nil)
			}
        }
    }
}

