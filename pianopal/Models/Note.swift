//
//  Note.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/13/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

enum Note : Int {
    case C, DFlat, D, EFlat, E, F, FSharp, G, AFlat, A, BFlat, B
    
    func isWhiteKey() -> Bool {
        return !isBlackKey()
    }
    
    func isBlackKey() -> Bool {
        switch self {
        case .C, .D, .E, .F, .G, .A, .B:
            return false
        default:
            return true
        }
    }
    
    func simpleDescription() -> String {
        switch self {
        case .C:
            return "C"
        case .DFlat:
            return "Db"
        case .D:
            return "D"
        case .EFlat:
            return "Eb"
        case .E:
            return "E"
        case .F:
            return "F"
        case .FSharp:
            return "F#"
        case .G:
            return "G"
        case .AFlat:
            return "Ab"
        case .A:
            return "A"
        case .BFlat:
            return "Bb"
        case .B:
            return "B"
        }
    }
}