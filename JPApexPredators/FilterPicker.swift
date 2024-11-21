//
//  FilterPicker.swift
//  JPApexPredators
//
//  Created by Nils Müller on 21.11.24.
//

import SwiftUI

struct FilterPicker: View {
    var movieOptions: [String]
    @Binding var selectedMovie: String
    @Binding var selectedType: PredatorType
    
    var body: some View {
        Menu {
            let selected = Binding(
                get: { self.selectedMovie },
                set: { self.selectedMovie = $0 == self.selectedMovie ? "" : $0}
            )
            Picker("Movie", selection: selected) {
                ForEach(movieOptions, id: \.self) { movie in
                    Label(movie, systemImage: "film")
                }
            }
            Picker("Predator Type", selection: $selectedType) {
                ForEach(PredatorType.allCases) { type in
                    Label(type.rawValue.capitalized, systemImage: type.icon)
                }
            }
        } label: {
            Image(systemName: "slider.horizontal.3")
        }
    }
}

#Preview {
    @Previewable @State var selectedMovie = "All"
    let predators = ApexPredatorViewModel()
    
    FilterPicker(movieOptions: predators.movies.reversed(), selectedMovie: $selectedMovie, selectedType: .constant(.all))
}
