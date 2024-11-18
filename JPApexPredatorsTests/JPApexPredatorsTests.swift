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
        apexPredatorViewModel.filter(by: type)
        #expect(apexPredatorViewModel.filteredItems.count == count)
    }

    @Test func searchForNYields11Predators() {
        // TODO: Change init() such that filteredItems is populated without filtering first. 😬
        apexPredatorViewModel.filter(by: .all)
        #expect(apexPredatorViewModel.search(for: "N").count == 11)
    }
    
    @Test func filterForAirAndSearchForNYields2Predators() {
        apexPredatorViewModel.filter(by: .air)
        #expect(apexPredatorViewModel.search(for: "N").count == 2)
    }
}
