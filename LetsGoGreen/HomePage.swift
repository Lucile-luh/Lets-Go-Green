//
//  joinAndCreatePage.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 16/10/2025.
//

import SwiftUI
//import Combine
import UIKit

struct CalendarView: UIViewRepresentable {
//    @ObservedObject var eventlist: EventListPage
    let interval: DateInterval
    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        return view
    }
    func updateUIView(_ uiView: UICalendarView, context: Context){
    
}
}


struct HomePage: View {
    @State private var currentIndex = 0
    let images = ["black","picking","clean","CommunityClean", "handshake", "litter", "cleanUp"]

    var body: some View {
        NavigationStack{
    
                VStack(){
                    ZStack {
                        
                        Image("treePlanting").resizable().ignoresSafeArea()
                            .opacity(0.8)
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 0.95, green: 1.0, blue: 0.95), // Light mint green
                                Color(red: 0.3, green: 0.85, blue: 0.3)   // Leafy green
                            ]),
                            
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                            
                        )
                        .ignoresSafeArea()
                        .opacity(0.2)
                    
                        VStack(){
                                ScrollView(.horizontal) {
                                    HStack {
                                        ForEach(0..<images.count, id: \.self) { index in
                                            Image(self.images[index])
                                                .resizable()
                                                .frame(width: 300, height: 280)
                                                .cornerRadius(20)
                                                .shadow(radius: 10)
                                                .padding()
                                        }
                                    }
                            }
                            
                        
                            NavigationLink(destination: EventListPage()) {
                                CalendarView(interval: DateInterval(start: .distantPast, end: .distantFuture))
                                    .frame(height: 300)
                                    .padding()
                            }
                        }
                    }
                    
                }
            }
           
        }
    }

#Preview {
    HomePage()
        
}
