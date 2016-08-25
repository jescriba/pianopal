//
//  ChordType.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/13/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

enum ChordType : Int {
    case Major, Minor, Diminished, Augmented, Sus2, Sus4, MajorSeventh, MinorSeventh, DominantSeventh, DiminishedSeventh, HalfDiminishedSeventh
    
    // Number of semitones from root
    func chordFormula() -> [Int] {
        switch self {
        case .Major:
            return [4, 7]
        case .Minor:
            return [3, 7]
        case .Diminished:
            return [3, 6]
        case .Augmented:
            return [4, 8]
        case .Sus2:
            return [2, 7]
        case .Sus4:
            return [5, 7]
        case .MajorSeventh:
            return [4, 7, 11]
        case .MinorSeventh:
            return [3, 7, 10]
        case .DominantSeventh:
            return [4, 7, 10]
        case .DiminishedSeventh:
            return [3, 6, 9]
        case .HalfDiminishedSeventh:
            return [3, 6, 10]
        }
    }
}