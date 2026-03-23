//
//  joinAndCreatePage.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 16/10/2025.
//

import SwiftUI
import UIKit
import SwiftData

struct CalendarView: UIViewRepresentable {
    
    let interval: DateInterval
    var eventDates: [Date]
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        view.delegate = context.coordinator
        
        return view
    }
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        uiView.reloadDecorations(forDateComponents: eventDates.map {
            Calendar.current.dateComponents([.year, .month, .day], from: $0)
        }, animated: true)
    }
    
    class Coordinator: NSObject, UICalendarViewDelegate {
        
        var parent: CalendarView
        let calendar = Calendar.current
        
        init(_ parent: CalendarView) {
            self.parent = parent
        }
        
        func calendarView(_ calendarView: UICalendarView,
                          decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            
            guard let date = calendar.date(from: dateComponents) else { return nil }
            
            if parent.eventDates.contains(where: { calendar.isDate($0, inSameDayAs: date) }) {
                return .default(color: .green, size: .medium)
            }
            return nil
        }
    }
    
}


struct HomePage: View {
    @ObservedObject var authViewModel: AuthViewModel
    @Query var events: [Event]
    let images = ["black","picking","clean","CommunityClean", "handshake", "litter", "cleanUp"]
    
    
    var body: some View {
        NavigationStack{
            ZStack {
                Image("treePlanting").resizable().ignoresSafeArea()
                    .opacity(0.8)
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.93, green: 1.0, blue: 0.93),
                        Color(red: 0.2, green: 0.7, blue: 0.35)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                .opacity(0.2)

                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Let’s Go Green")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                        Text("Find local cleanups, plant trees, and join your community.")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 8)
                    .padding(.horizontal, 16)
                    VStack{
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<images.count, id: \.self) { index in
                                Image(images[index])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 300, height: 280)
                                    .clipped()
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .shadow(radius: 10)
                                    .padding()
                            }
                        }
                    }
                    .padding(.bottom, 16)
                    
                    ScrollView {
                        CalendarView(
                            interval: DateInterval(start: .distantPast, end: .distantFuture),
                            eventDates: events.map { $0.date }
                        )
                        .frame(height: 300)
                        .padding()
                        .padding(.top, 16)
                    }
                }
                }
            }
            .safeAreaInset(edge: .bottom) {
                BottomNavBar()
            }
        }
    }
}

#Preview {
    HomePage(authViewModel: AuthViewModel())
}
