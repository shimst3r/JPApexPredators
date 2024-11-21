//
//  ApexPredatorViewModel.swift
//  JPApexPredators
//
//  Created by Nils Müller on 18.11.24.
//

import Foundation

class ApexPredatorViewModel {
    var allItems: [ApexPredator] = []
    var filteredItems: [ApexPredator] = []

    var movies: [String] {
        let result = allItems.flatMap { predator in
            predator.movies
        }
        return NSOrderedSet(array: result).array as! [String]
    }

    init() {
        decode()
    }

    func decode() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allItems = try decoder.decode([ApexPredator].self, from: data)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
    
    func filter(by movie: String, by type: PredatorType) {
        if !movie.isEmpty {
            filteredItems = filteredItems.filter { predator in
                predator.movies.contains(movie)
            }
        }
        if type != .all {
            filteredItems = filteredItems.filter { predator in
                predator.type == type
            }
        }
    }
    
    func reset() {
        filteredItems = allItems
    }
    
    func search(for query: String) -> [ApexPredator] {
        guard !query.isEmpty else { return filteredItems }
        return filteredItems.filter { predator in
            predator.name.localizedStandardContains(query)
        }
    }

    func sort(by alphabetical: Bool) {
        filteredItems.sort { alphabetical ? $0.name < $1.name : $0.id < $1.id }
    }
}
