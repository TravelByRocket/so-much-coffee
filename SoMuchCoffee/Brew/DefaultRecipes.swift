//
//  DefaultRecipes.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 3/13/20.
//  Copyright © 2020 Bryan Costanza. All rights reserved.
//

import SwiftUI

let jsonStringRecipes = """
[
	{"id":"95E4F227-C7F3-46D9-A626-3BE4A01D04F9","name":"Unbelievable Brew","steps":[]},
	{"id":"72A16CD5-8216-4712-8A7C-1A91D10875CB","name":"Lucky Beans","steps":[]},
	{"id":"4B4479EB-02B4-45C4-811B-B8909348697D","name":"Brew of Faith","steps":[]},
	{"id":"C932DD25-27EE-4901-A7F3-C6B5B688FF27","name":"Caffeine Healer","steps":[]},
	{"id":"F5224C22-3481-4401-AA5A-34AF9F830286","name":"Can't Stop Brewing","steps":[]},
	{"id":"B745BF6E-3D9B-4B73-8B40-54B554A79525","isUpright":false,"steps":[
		{"isCombinable":true,"id":"FC99A1B7-ED01-4DE3-BDE9-E864306D68E0","forceAsLastGroupedStep":false,
			"descriptor":{"base":"heatWater","heatWaterParams":{"tempC":73.888888888888886}}},
		{"isCombinable":true,"id":"47CA3E00-B8CD-4399-8AA6-36DF1B1EEC23","forceAsLastGroupedStep":false,
			"descriptor":{"base":"grind","grindParams":{"grams":20}}},
		{"isCombinable":true,"id":"C5C400AC-8D3B-4E79-943A-DC9847CC4C44","forceAsLastGroupedStep":false,
			"descriptor":{"base":"rinseFilter"}},
		{"isCombinable":false,"id":"0FF63436-71D8-4946-A48A-3F17E6263AC0","forceAsLastGroupedStep":false,
			"descriptor":{"base":"addWater","addWaterParams":{"seconds":20,"grams":30}}},
		{"isCombinable":false,"id":"85E37D4F-4F52-4175-A740-CBEE984AE010","forceAsLastGroupedStep":false,
			"descriptor":{"base":"stir","plungeParams":{"seconds":20}}},
		{"isCombinable":true,"id":"BA4228E7-0691-4ADE-8348-09FF93401890","forceAsLastGroupedStep":false,
			"descriptor":{"base":"installFilter"}},
		{"isCombinable":true,"id":"1B690F2A-2D3B-4A67-90CF-BE1B85B3EF5D","forceAsLastGroupedStep":false,
			"descriptor":{"base":"installPlunger"}},
		{"isCombinable":false,"id":"1FC1F48D-E30C-4ED0-B03F-203D8B2771C9","forceAsLastGroupedStep":true,
			"descriptor":{"base":"wait","waitParams":{"seconds":20}}},
		{"isCombinable":false,"id":"FAAE48DA-06EB-41D4-BCD6-083EF046F1C5","forceAsLastGroupedStep":false,
			"descriptor":{"base":"plunge","plungeParams":{"seconds":20}}}
		],"name":"Energy Tranquil Caffeine Mar 12, 2020","isPaper":true}
]
"""

let jsonDataRecipes = Data(jsonStringRecipes.utf8)
