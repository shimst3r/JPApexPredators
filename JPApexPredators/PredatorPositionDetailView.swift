//
//  PredatorPositionDetailView.swift
//  JPApexPredators
//
//  Created by Nils Müller on 19.11.24.
//

import MapKit
import SwiftUI

struct PredatorPositionDetailView: View {
    let predators = ApexPredatorViewModel()
    @State var satelliteView = false
    
    @State var position: MapCameraPosition

    var body: some View {
        Map(position: $position) {
            ForEach(predators.allItems) { predator in
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                }
            }
        }
        .mapStyle(satelliteView ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button {
                satelliteView.toggle()
            } label: {
                Image(systemName: satelliteView ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(3)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 7))
                    .shadow(radius: 3)
                    .padding()
            }
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    let predator = ApexPredatorViewModel().allItems[2]

    PredatorPositionDetailView(position: .camera(MapCamera(centerCoordinate: predator.location, distance: 1_000, heading: 250, pitch: 80)))
        .preferredColorScheme(.dark)
}
