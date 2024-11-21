//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Nils Müller on 18.11.24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    let predators = ApexPredatorViewModel()
    @State var alphabeticalSorting = false
    @State var searchText = ""
    @State var selectedMovie = ""
    @State var selectedType = PredatorType.all
    
    var filteredPredators: [ApexPredator] {
        predators.reset()
        predators.filter(by: selectedMovie, by: selectedType)
        predators.sort(by: alphabeticalSorting)
        return predators.search(for: searchText)
    }

    var body: some View {
        NavigationStack {
            List(filteredPredators) { predator in
                NavigationLink {
                    PredatorDetailView(
                        predator: predator,
                        position: .camera(MapCamera(centerCoordinate: predator.location, distance: 30_000)))
                } label: {
                    HStack {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        VStack(alignment: .leading) {
                            Text(predator.name)
                                .fontWeight(.bold)
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: alphabeticalSorting)
            .animation(.default, value: searchText)
            .animation(.default, value: selectedMovie)
            .animation(.default, value: selectedType)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        alphabeticalSorting.toggle()
                    } label: {
                        Image(systemName: alphabeticalSorting ? "textformat" : "film")
                            .symbolEffect(.bounce, value: alphabeticalSorting)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    FilterPicker(movieOptions: predators.movies, selectedMovie: $selectedMovie, selectedType: $selectedType)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
