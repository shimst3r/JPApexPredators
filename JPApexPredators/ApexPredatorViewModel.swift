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

    func filter(by type: PredatorType) {
        if type == .all {
            filteredItems = allItems
        } else {
            filteredItems = allItems.filter { predator in
                predator.type == type
            }
        }
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
