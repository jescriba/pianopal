//
//  ScaleType.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/13/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

enum ScaleType : Int {
    case Major, NaturalMinor, MelodicMinor, MinorPentatonic, HarmonicMajor, HarmonicMinor, HungarianMajor, HungarianMinor
    
    func scaleFormula() -> [Int] {
        switch self {
        case .Major:
            return [2, 4, 5, 7, 9, 11]
        case .NaturalMinor:
            return [2, 3, 5, 7, 8, 10]
        case .HarmonicMinor:
            return [2, 3, 5, 7, 8, 11]
        case .MelodicMinor:
            return [2, 3, 5, 7, 9, 11]
        case .MinorPentatonic:
            return [3, 5, 7, 10]
        case .HarmonicMajor:
            return [2, 4, 5, 7, 8, 11]
        case .HungarianMajor:
            return [3, 4, 6, 7, 9, 10]
        case .HungarianMinor:
            return [2, 3, 6, 7, 8, 11]
        }
    }
}