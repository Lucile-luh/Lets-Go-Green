//
//  logInPage.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 16/10/2025.
//

import SwiftUI

struct logInPage: View {
    @State private var username: String = ""
    @State private var Password: String = ""
    
    var body: some View {
        
        VStack {
            
            Image( "appIconLTG")
                .resizable()
                .frame(width: 200, height: 200)
                .aspectRatio(1,contentMode: .fit)
            
        }
        .padding(20)
    }
}

#Preview {
    logInPage()
}
