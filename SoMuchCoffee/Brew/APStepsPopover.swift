//
//  APStepsPopover.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/10/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct APStepsPopover: View {
    @Binding var showPopover: Bool
    
    @State var optHeatWater: Bool = false
    @State var optGrind: Bool = false
    @State var optAddWater: Bool = false
    @State var optStir: Bool = false
    @State var optWait: Bool = false
    @State var optPlunge: Bool = false
    
    var body: some View {
        
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
                .opacity(1)
            
            VStack{
                Text("Preparation")
                HStack{
                    VStack {
                        Text("Heat\nWater")
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 100,height: 100)
                    .background(Color.white)
                    .border(appDarkGray)
                    .onTapGesture {
                        self.optHeatWater = true
                    }
                    VStack {
                        Text("Grind")
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 100,height: 100)
                    .background(Color.white)
                    .border(appDarkGray)
                    .onTapGesture {
                        self.optGrind = true
                    }
                    VStack {
                        Text("Rinse\nFilter")
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 100,height: 100)
                    .background(Color.white)
                    .border(appDarkGray)
                    .onTapGesture {
                        self.showPopover = false
                    }
                }
                .padding(.bottom)
                .padding(.top,0)
                
                Text("Process")
                HStack{
                    VStack {
                        Text("Add\nWater")
                            .multilineTextAlignment(.center)
                            .onTapGesture {
                                self.optAddWater = true
                        }
                    }
                    .frame(width: 100,height: 100)
                    .background(Color.white)
                    .border(appDarkGray)
                    VStack {
                        Text("Stir")
                            .multilineTextAlignment(.center)
                            .onTapGesture {
                                self.optStir = true
                        }
                    }
                    .frame(width: 100,height: 100)
                    .background(Color.white)
                    .border(appDarkGray)
                    VStack {
                        Text("Wait")
                            .multilineTextAlignment(.center)
                            .onTapGesture {
                                self.optWait = true
                        }
                    }
                    .frame(width: 100,height: 100)
                    .background(Color.white)
                    .border(appDarkGray)
                }
                .padding(.bottom)
                .padding(.top,0)
                
                Text("Completion")
                HStack{
                    VStack {
                        Text("Insert\nPlunger")
                            .multilineTextAlignment(.center)
                            .onTapGesture {
                                self.showPopover = false
                        }
                    }
                    .frame(width: 100,height: 100)
                    .background(Color.white)
                    .border(appDarkGray)
                    VStack {
                        Text("Plunge")
                            .multilineTextAlignment(.center)
                            .onTapGesture {
                                self.optPlunge = true
                        }
                    }
                    .frame(width: 100,height: 100)
                    .background(Color.white)
                    .border(appDarkGray)
                    VStack {
                        Text("Attach\nFilter")
                            .multilineTextAlignment(.center)
                            .onTapGesture {
                                self.showPopover = false
                        }
                    }
                    .frame(width: 100,height: 100)
                    .background(Color.white)
                    .border(appDarkGray)
                }
                .padding(.bottom)
                .padding(.top,0)
                Text("Dismiss").foregroundColor(Color.blue)
                    .padding()
                    .onTapGesture {
                        self.showPopover = false
                }
                Spacer()
            }
            
            if optHeatWater || optGrind || optAddWater || optStir || optWait || optPlunge {
                Color.white
                .edgesIgnoringSafeArea(.all)
                .opacity(1)
            }
            
            VStack{
                if optHeatWater {
                    VStack {
                        
                        HeatWaterSettings()
                        Text("Dismiss").foregroundColor(Color.blue)
                            .padding()
                            .onTapGesture {
                                self.optHeatWater = false
                                self.showPopover = false
                        }
                    }
                } else if optGrind {
                    GrindSettings()
                    Text("Dismiss").foregroundColor(Color.blue)
                        .padding()
                        .onTapGesture {
                            self.optGrind = false
                            self.showPopover = false
                    }
                } else if optAddWater {
                    AddWaterSettings()
                    Text("Dismiss").foregroundColor(Color.blue)
                        .padding()
                        .onTapGesture {
                            self.optAddWater = false
                            self.showPopover = false
                    }
                } else if optStir {
                    StirSettings()
                    Text("Dismiss").foregroundColor(Color.blue)
                        .padding()
                        .onTapGesture {
                            self.optStir = false
                            self.showPopover = false
                    }
                } else if optWait {
                    WaitSettings()
                    Text("Dismiss").foregroundColor(Color.blue)
                        .padding()
                        .onTapGesture {
                            self.optWait = false
                            self.showPopover = false
                    }
                } else if optPlunge {
                    PlungeSettings()
                    Text("Dismiss").foregroundColor(Color.blue)
                        .padding()
                        .onTapGesture {
                            self.optPlunge = false
                            self.showPopover = false
                    }
                }
                if optHeatWater || optGrind || optAddWater || optStir || optWait || optPlunge {
                    Spacer()
                }
            }
        }
    }
}

struct APStepsPopover_Previews: PreviewProvider {
    @State private static var fakeEnabler: Bool = true
    static var previews: some View {
        APStepsPopover(showPopover: $fakeEnabler)
    }
}

