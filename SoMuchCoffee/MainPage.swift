//
//  MainPage.swift
//  SoMuchCoffee
//
//  Created by Bryan Costanza on 12/15/19.
//  Copyright © 2019 Bryan Costanza. All rights reserved.
//

import SwiftUI

struct MainPage: View {
    let menuFontSize: CGFloat = 18
    @EnvironmentObject var settings: UserSettings
    var body: some View {

        VStack {
            // TITLE
            Text("So Much Coffee")
                .foregroundColor(appOrange)
                .font(Font.custom(alfa,size: 40))
            
            // FIRST ROW
            HStack {
                VStack{
                    Spacer()
//                    Text("Section Under Construction")
//                        .foregroundColor(Color.orange)
//                        .multilineTextAlignment(.center)
                    Image("find").resizable().aspectRatio(contentMode: .fit).padding()
                    Text("Find").font(Font.custom(lato,size: menuFontSize))
                }
                .frame(width: (UIScreen.main.bounds.width - 30)/3, height: UIScreen.main.bounds.height/3)
                .border(appDarkGray, width: 1)
                .onTapGesture {self.settings.curPage = "FIND"}
                
                VStack{
                    Spacer()
                    Image("brew").resizable().aspectRatio(contentMode: .fit)
                    Text("Brew").font(Font.custom(lato,size: menuFontSize))
                }
                .frame(width: (UIScreen.main.bounds.width - 30)/3, height: UIScreen.main.bounds.height/3)
                .border(appDarkGray, width: 1)
                .onTapGesture {self.settings.curPage = "BREW"}

                VStack{
                    Spacer()
//                    Text("Section Under Construction")
//                        .foregroundColor(Color.orange)
//                        .multilineTextAlignment(.center)
                    Image("log").resizable().aspectRatio(contentMode: .fit)
                    Text("Log").font(Font.custom(lato,size: menuFontSize))
                }
                .frame(width: (UIScreen.main.bounds.width - 30)/3, height: UIScreen.main.bounds.height/3)
                .border(appDarkGray, width: 1)
                .onTapGesture {self.settings.curPage = "LOG"}
            }.padding()
                            
            //SECOND ROW
            HStack {
                // LEFT BUTTON
                VStack{
                    Spacer()
//                    Text("Section Under Construction")
//                        .foregroundColor(Color.orange)
//                        .multilineTextAlignment(.center)
                    Image("roasters").resizable().aspectRatio(contentMode: .fit).padding()
                    Text("Roasters").font(Font.custom(lato,size: menuFontSize))
                }.frame(width: (UIScreen.main.bounds.width - 30)/3, height: UIScreen.main.bounds.height/3)
                .border(appDarkGray, width: 1)
                .onTapGesture {self.settings.curPage = "ROASTERS"}
                
                                    
                // MIDDLE BUTTON
                VStack{
                    Spacer()
//                    Text("Section Under Construction")
//                        .foregroundColor(Color.orange)
//                        .multilineTextAlignment(.center)
                    Image("origins").resizable().aspectRatio(contentMode: .fit)
                    Text("Origins").font(Font.custom(lato,size: menuFontSize))
                }.frame(width: (UIScreen.main.bounds.width - 30)/3, height: UIScreen.main.bounds.height/3)
                .border(appDarkGray, width: 1)
                .onTapGesture {self.settings.curPage = "ORIGINS"}
                
                                    
                // RIGHT BUTTON
                VStack{
                    Spacer()
//                    Text("Section Under Construction")
//                        .foregroundColor(Color.orange)
//                        .multilineTextAlignment(.center)
                    Image("flavors").resizable().aspectRatio(contentMode: .fit)
                    Text("Flavors").font(Font.custom(lato,size: menuFontSize))
                }.frame(width: (UIScreen.main.bounds.width - 30)/3, height: UIScreen.main.bounds.height/3)
                .border(appDarkGray, width: 1)
                .onTapGesture {self.settings.curPage = "FLAVORS"}
            }
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
//        MainPage().environmentObject(UserSettings())
        ContentView().environmentObject(UserSettings())
    }
}
