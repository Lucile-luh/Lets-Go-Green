//
//  Eventlist.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 22/10/2025.
//

import SwiftUI
import SwiftData

struct EventListPage: View {
    @Environment(\.modelContext) private var modelContext
    @Query var event: [Event]
    @EnvironmentObject var viewModel: EventViewModel
    var body: some View {
        
        NavigationStack {
            ZStack {
                // MARK: background
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
                VStack {
                    
                    Text("Event List")
                        .font(.largeTitle)
                        .padding()
                    
                    //   MARK: list display
                    List {
                        ForEach(event, id: \.id) { event in
                            VStack(alignment: .leading) {
                                Text(event.title)
                                    .font(.headline)
                                Text(event.info)
                                    .font(.subheadline)
                                Text("Location: \(event.location)")
                                    .font(.subheadline)
                                Text("Date: \(event.date, formatter: DateFormatter.shortDate) Time: \(event.time, formatter: DateFormatter.shortTime)")
                                    .font(.footnote)
                                
                                Label(event.location, systemImage: "mappin.and.ellipse")
                                
                                    .font(.footnote)
                                    .foregroundColor(.darker)
                                    .fontWeight(.heavy)
                                HStack{
                                    NavigationLink(destination: joinEventPage(event: event)) {
                                        Image(systemName: "person.crop.circle.fill.badge.plus")
                                            .imageScale(.large)
                                            .padding(.vertical, 8)
                                        VStack{
                                            Text("Join")
                                        }
                                    }
                                    .foregroundStyle(.darker)
                                }
                            }
                            
                            .padding()
                        }
                        
                        .onDelete(perform: deleteItems)
                        
                        
                        
                        //MARK: Create event button
                        
                        NavigationLink(destination: createEventPage()) {
                            Image(systemName: "rectangle.stack.fill.badge.plus")
                                .imageScale(.large)
                                .padding(.vertical, 8)
                        }
                        .foregroundStyle(.darker)
                    }
                    .scrollContentBackground(.hidden)
                    .onAppear {
                        
                    }
                    
                }
                .safeAreaInset(edge: .bottom) {
                    BottomNavBar()
                }
            }
        }
    }
    // MARK: delete func
    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let item = event[index]
            modelContext.delete(item)
        }
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context after deletion: \(error)")
        }
    }
}

extension DateFormatter {
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }
    
    static var shortTime: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
    
}


#Preview {
    EventListPage()
}
