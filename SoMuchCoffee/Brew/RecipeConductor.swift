//
//  RecipeConductor.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/17/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct RecipeConductor: View {
	var recipe: Recipe
    @State var timeElapsedSec: CGFloat = 0
    var recipeTotalTimeSec : CGFloat = 115
    
    @State var timeElapsedStepSec: CGFloat = 0
    
    let timer = Timer.publish(every: Double(timerInterval), on: .main, in: .common).autoconnect()
    
    @State var curStep = 0
    @State var clockIsRunning = false
    
    let switchTimeSec: [CGFloat] = [0,15,35,65,95,115]
    
    var body: some View {
        
        VStack {
//            HStack {
//                Spacer()
//                GoHome()
//            }.padding()
            Spacer()
            if curStep == 0 {
                Text("Prepare for Brewing")
                GrindStep(grinderName: "Rok", grindSetting: "10.5", beanMass: 35)
                HeatWaterStep(temperature: 183, isFahrenheit: true)
                RinseFilterStep()
                Text("Tap to start brewing")
                    .foregroundColor(Color.blue)
                    .onTapGesture {self.clockIsRunning = true}
                    .padding()
                    .border(Color.blue, width: 1)
                    .padding()
                Text("Next Step: Add Water")
            } else if curStep == 1 {
                AddWaterStep(timeElapsedSec: $timeElapsedStepSec, totalTimeSec: switchTimeSec[curStep] - switchTimeSec[curStep - 1], waterMassG: 150)
                Text("Next Step: Stir")
            } else if curStep == 2 {
                StirStep(timeElapsedSec: $timeElapsedStepSec, totalTimeSec: switchTimeSec[curStep] - switchTimeSec[curStep - 1])
                Text("Next Step: Wait")
            } else if curStep == 3 {
//                InstallFilterStep()
				Text("Placeholder for InstallFilter")
                WaitStep(timeElapsedSec: $timeElapsedStepSec, totalTimeSec: switchTimeSec[curStep] - switchTimeSec[curStep - 1])
                Text("Next Step: Plunge")
            } else if curStep == 4 {
                PlungeStep(timeElapsedSec: $timeElapsedStepSec, totalTimeSec: switchTimeSec[curStep] - switchTimeSec[curStep - 1])
                Text("Next Step: Add Water")
            } else if curStep == 5 {
                AddWaterStep(timeElapsedSec: $timeElapsedStepSec, totalTimeSec: switchTimeSec[curStep] - switchTimeSec[curStep - 1], waterMassG: 160)
                Text("Next Step: Enjoy")
            } else {
                Text("Coffee Time!")
                    .font(.largeTitle)
//                GoHome().padding()
                Spacer()
            }
//        Spacer()
            VStack {
                
//                if curStep != 0 && curStep != 6 {
                    HStack{
                        Text("< Previous")
                            .foregroundColor(curStep > 0 ? Color.black : appLightGray)
                            .onTapGesture {
//                            self.timeElapsedSec = self.switchTimeSec[self.curStep-2]
                                if self.curStep == 1 {
                                    self.timeElapsedSec = 0
                                    self.clockIsRunning = false
                                    self.curStep = 0
                                } else {
                                    self.timeElapsedSec = self.switchTimeSec[self.curStep-2]
                                    self.clockIsRunning = true // this only applies when curStep = 6 but seems unecessary to write anoth logic section for this
                                }
                            }
                        Spacer()
                        Text("Next >")
                            .foregroundColor(clockIsRunning ? Color.black : appLightGray)
                            .onTapGesture {
                                if self.clockIsRunning {
                                    self.timeElapsedSec = self.switchTimeSec[self.curStep]
                                }
                        }
                    }.padding()
//                }
                
                TimerPillTotal(timeElapsedSec: $timeElapsedSec, timeDurationSec: recipeTotalTimeSec)
					.navigationBarTitle(recipe.name)
					.onReceive(timer) { _ in
    //            if self.timeElapsedSec <= self.recipeTotalTimeSec && self.clockIsRunning {
                if self.clockIsRunning {
                    self.timeElapsedSec += timerInterval
                    if self.timeElapsedSec < self.switchTimeSec[0] {
                        self.curStep = 0
                    } else if self.timeElapsedSec < self.switchTimeSec[1] {
                        self.curStep = 1
                    } else if self.timeElapsedSec < self.switchTimeSec[2] {
                        self.curStep = 2
                    } else if self.timeElapsedSec < self.switchTimeSec[3] {
                        self.curStep = 3
                    } else if self.timeElapsedSec < self.switchTimeSec[4] {
                        self.curStep = 4
                    } else if self.timeElapsedSec < self.switchTimeSec[5] {
                        self.curStep = 5
                    } else {
                        self.curStep = 6
                    }
                    self.timeElapsedStepSec = self.timeElapsedSec - self.switchTimeSec[self.curStep-1]
                    if self.timeElapsedSec >= self.recipeTotalTimeSec {
                        self.clockIsRunning = false
                        self.timeElapsedSec = self.recipeTotalTimeSec
                    }
                }
                }
            }
        }
    }
}

struct RecipeConductor_Previews: PreviewProvider {
    static var recipes: [Recipe] = testRecipes
	static var previews: some View {
		NavigationView{
			RecipeConductor(recipe: recipes[0])
		}
    }
}
