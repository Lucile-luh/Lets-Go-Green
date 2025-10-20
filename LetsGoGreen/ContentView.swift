//
//  ContentView.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 16/10/2025.
//

import SwiftUI

//let gradientColors: [Color] = [
//    .middlecolor,
//    .universal,
//    .topColour
//]

struct ContentView: View {
    
    var body: some View {
        
        TabView {
            welcomePage()
            logInPage()
                
              }
        
    }
      
}

#Preview {
    ContentView()
}
