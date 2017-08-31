//
//  Note.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/13/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

enum Note : Int {
    case c, dFlat, d, eFlat, e, f, fSharp, g, aFlat, a, bFlat, b
    
    func isWhiteKey() -> Bool {
        return !isBlackKey()
    }
    
    func isBlackKey() -> Bool {
        switch self {
        case .c, .d, .e, .f, .g, .a, .b:
            return false
        default:
            return true
        }
    }
    
    func simpleDescription() -> String {
        switch self {
        case .c:
            return "C"
        case .dFlat:
            return "Db"
        case .d:
            return "D"
        case .eFlat:
            return "Eb"
        case .e:
            return "E"
        case .f:
            return "F"
        case .fSharp:
            return "F#"
        case .g:
            return "G"
        case .aFlat:
            return "Ab"
        case .a:
            return "A"
        case .bFlat:
            return "Bb"
        case .b:
            return "B"
        }
    }

    func frequency() -> Double {
        switch self {
        case .c:
            return 16.35
        case .dFlat:
            return 17.32
        case .d:
            return 18.35
        case .eFlat:
            return 19.45
        case .e:
            return 20.60
        case .f:
            return 21.83
        case .fSharp:
            return 23.12
        case .g:
            return 24.50
        case .aFlat:
            return 25.96
        case .a:
            return 27.50
        case .bFlat:
            return 29.14
        case .b:
            return 30.87
        }
    }
}
