//
//  JPApexPredatorsTests.swift
//  JPApexPredatorsTests
//
//  Created by Nils Müller on 18.11.24.
//

@testable import JPApexPredators
import Testing

struct JPApexPredatorsTests {
    let apexPredatorViewModel = ApexPredatorViewModel()

    @Test(arguments: zip(PredatorType.allCases, [21, 17, 3, 1])) func filterItemsByPredatorType(_ type: PredatorType, _ count: Int) {
        apexPredatorViewModel.filter(by: "", by: type)
        #expect(apexPredatorViewModel.filteredItems.count == count)
    }

    @Test func searchForNYields11Predators() {
        apexPredatorViewModel.filter(by: "", by: .all)
        #expect(apexPredatorViewModel.search(for: "N").count == 11)
    }

    @Test func filterForAirAndSearchForNYields2Predators() {
        apexPredatorViewModel.filter(by: "", by: .air)
        #expect(apexPredatorViewModel.search(for: "N").count == 2)
    }

    @Test func moviesPropertyReturnsOrderedMovies() {
        let movies = apexPredatorViewModel.movies

        #expect(movies.first == "Jurassic Park")
        #expect(movies.last == "Jurassic World: Dominion")
    }
}
