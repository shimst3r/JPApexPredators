//
//  SortAndFilterExerciseTests.swift
//  JPApexPredatorsTests
//
//  Created by Nils Müller on 19.11.24.
//

import Foundation
import Testing

struct SortAndFilterExerciseTests {
    // sortAndFilter drops all strings that start with a vowel and sorts in reversed
    // alphabetical order.
    func sortAndFilter(_ stringArray: [String]) -> [String] {
        let regex = try! NSRegularExpression(pattern: "^[^aeiou]")
        return stringArray.filter { item in
            return regex.firstMatch(in: item.lowercased(), range: NSRange(location: 0, length: item.utf16.count)) != nil
        }.sorted { lhs, rhs in
            lhs.lowercased() > rhs.lowercased()
        }
    }

    @Test func testExample1() {
        let given = ["Alan", "Timothy", "Kevin", "Ethan", "Matthew"]
        let expected = ["Timothy", "Matthew", "Kevin"]
        
        #expect(sortAndFilter(given) == expected)
    }
    
    @Test func testExample2() {
        let given = ["lion", "tiger", "bear", "eagle", "Big Bird", "raccoon", "skunk", "Toothless", "aardvark", "baboon", "Old Yeller"]
        let expected = ["Toothless", "tiger", "skunk", "raccoon", "lion", "Big Bird", "bear", "baboon"]
        
        #expect(sortAndFilter(given) == expected)
    }
}
