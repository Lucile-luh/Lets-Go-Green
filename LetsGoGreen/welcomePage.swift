//
//  welcomePage.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 16/10/2025.
//

import SwiftUI

struct welcomePage: View {
    @State private var animateAppIcon = false
    var body: some View {
        
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .foregroundStyle(Color(.systemGray6))
                    .opacity(animateAppIcon ? 1 : 0)
                
                Image(systemName: "tree")
                    .fontWeight(.heavy)
                    .font(.system(size: 100))
                    .foregroundStyle(.middlecolor)
                
            }
                
            
                    
                    Text("Welcome to ")
                        .fontDesign(.rounded)
                        .fontWeight(.heavy)
                        .font(Font.largeTitle.bold())
                        .foregroundColor(.topColour)
                    
                    
                        .padding()
                    
                    Text("a green planner for organizing community clean-up and tree-planting events..")
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .padding(10)
                        .font(.title2)
                        .foregroundStyle(.topColour)
                }
                .onAppear{
                    animateAppIcon = true
                }
            
        }
    
}

#Preview {
    welcomePage()
}
