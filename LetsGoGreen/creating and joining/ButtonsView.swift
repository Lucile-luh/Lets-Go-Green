//
//  ButtonsView.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 3/2/2026.
//

import SwiftUI
import MapKit

struct ButtonsView: View {
    @Binding var searchResults: [MKMapItem]
    
    var body: some View {
        HStack{
            Button{
                search(for:"tree planting")
            }label: {
                Label("Tree planting",systemImage: "tree.circle")
            }
            .buttonStyle(.borderedProminent)
            
            Button{
                search(for: "clean up")
               
            } label:{
                Label("Clean Up", systemImage: "apple.meditate.square.stack.fill")
            }
            .buttonStyle(.borderedProminent)
        }
        .labelStyle(.iconOnly)
        
    }
    
    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(
        center: .cleanUpArea,
        span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125))
        
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
}

#Preview {
    ButtonsView(searchResults: .constant([]))
}
