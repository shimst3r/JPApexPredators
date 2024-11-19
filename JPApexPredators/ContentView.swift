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
    @State var selectedType = PredatorType.all

    var filteredPredators: [ApexPredator] {
        predators.filter(by: selectedType)
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
                    Menu {
                        Picker("Filter", selection: $selectedType) {
                            ForEach(PredatorType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
