//
//  MapView.swift
//  LetsGoGreen
//
//  Created by LUCILE G MUCHEMWA on 3/2/2026.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let cleanUpArea = CLLocationCoordinate2D(latitude: -17.93378, longitude: 25.81196 )
}


struct MapView: View {
    @State private var searchResults: [MKMapItem] = []
    var body: some View {
        Map{
            Annotation("Event", coordinate: .cleanUpArea) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.background)
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.green, lineWidth: 5)
                    Image (systemName: "tree")
                        .padding(5)
                }
            }
            .annotationTitles(.hidden)
            
            
            ForEach(searchResults, id: \.self) { result in
                Marker(item: result)
            }
        }
        .mapStyle(.imagery(elevation: .realistic))
        .safeAreaInset(edge: .bottom) {
            HStack{
                Spacer()
                ButtonsView(searchResults: $searchResults)
            }
        }
    }
}


#Preview {
    MapView()
}
