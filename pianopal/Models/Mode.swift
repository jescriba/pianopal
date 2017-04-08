//
//  Mode.swift
//  pianopal
//
//  Created by Joshua Escribano on 4/1/17.
//  Copyright © 2017 Joshua Escribano. All rights reserved.
//

import Foundation

enum Mode: Int {
    case ionian, dorian, phrygian, lydian, mixolydian, aeolian, locrian
    
    func simpleDescription() -> String {
        switch self {
        case .ionian:
            return "1 Ionian"
        case .dorian:
            return "2 Dorian"
        case .phrygian:
            return "3 Phrygian"
        case .lydian:
            return "4 Lydian"
        case .mixolydian:
            return "5 Mixolydian"
        case .aeolian:
            return "6 Aeolian"
        case .locrian:
            return "7 Locrian"
        }
    }
}
