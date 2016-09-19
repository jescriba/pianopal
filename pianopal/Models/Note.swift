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
}
