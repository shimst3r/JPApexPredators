//
//  PredatorType.swift
//  JPApexPredators
//
//  Created by Nils Müller on 18.11.24.
//

import Foundation
import SwiftUI

enum PredatorType: String, CaseIterable, Decodable, Identifiable  {
    case all
    case land
    case air
    case sea
    
    var id: PredatorType { self }

    var background: Color {
        switch self {
        case .land: return .brown
        case .air: return .teal
        case .sea: return .blue
        default: return .white
        }
    }

    var icon: String {
        switch self {
        case .all: return "square.stack.3d.up.fill"
        case .land: return "leaf.fill"
        case .air: return "wind"
        case .sea: return "drop.fill"
        }
    }
}
