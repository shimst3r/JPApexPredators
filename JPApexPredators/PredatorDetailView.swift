//
//  PredatorDetailView.swift
//  JPApexPredators
//
//  Created by Nils Müller on 19.11.24.
//

import MapKit
import SwiftUI

struct PredatorDetailView: View {
    let predator: ApexPredator
    @State var position: MapCameraPosition

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: .clear, location: 0.8),
                                    Gradient.Stop(color: .black, location: 1)
                                ],
                                startPoint: .top, endPoint: .bottom
                            )
                        }
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 1.5, height: geometry.size.height / 3)
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                        .offset(y: 20)
                }

                VStack(alignment: .leading) {
                    Text(predator.name)
                        .font(.largeTitle)
                    NavigationLink {
                        PredatorPositionDetailView(position: .camera(MapCamera(centerCoordinate: predator.location, distance: 1_000, heading: 250, pitch: 80)))
                    } label: {
                        Map(position: $position) {
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden)
                        }
                    }
                    .frame(height: 125)
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(alignment: .trailing) {
                        Image(systemName: "greaterthan")
                            .imageScale(.large)
                            .font(.title3)
                            .padding(.trailing, 5)
                    }
                    .overlay(alignment: .topLeading) {
                        Text("Current Location")
                            .padding([.leading, .bottom], 5)
                            .padding(.trailing, 8)
                            .background(.black.opacity(1 / 3))
                            .clipShape(.rect(bottomTrailingRadius: 10))
                    }
                    .clipShape(.rect(cornerRadius: 10))

                    Text("Appears In:")
                        .font(.title)
                    ForEach(predator.movies, id: \.self) { movie in
                        Text("‣ " + movie)
                            .font(.subheadline)
                    }
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top, 15)
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        Text(scene.sceneDescription)
                            .font(.caption)
                    }
                    // Link to Predator Wiki
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
                .padding()
                .padding(.bottom)
                .frame(width: geometry.size.width, alignment: .leading)
            }
            .ignoresSafeArea()
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    let predator = ApexPredatorViewModel().allItems[10]

    PredatorDetailView(
        predator: predator,
        position: .camera(MapCamera(centerCoordinate: predator.location, distance: 30_000))
    )
    .preferredColorScheme(.dark)
}
