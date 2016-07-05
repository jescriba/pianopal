//
//  KeyProperties.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/13/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class KeyProperties {
    
    static func width(note: Note) -> CGFloat {
        switch note {
        case .DFlat, .EFlat, .FSharp, .AFlat, .BFlat:
            return CGFloat(0.077)
        case .D, .E, .C:
            return CGFloat(0.138)
        case .F:
            return CGFloat(0.148)
        default:
            return CGFloat(0.146)
        }
    }
    
    static func height(note: Note) -> CGFloat {
        if note.isBlackKey() {
            return CGFloat(0.64)
        }
        return CGFloat(1)
    }
    
    static func x(note: Note) -> CGFloat {
        switch note {
        case .C:
            return CGFloat(0)
        case .DFlat:
            return CGFloat(0.085)
        case .D:
            return CGFloat(0.138)
        case .EFlat:
            return CGFloat(0.254)
        case .E:
            return CGFloat(0.276)
        case .F:
            return CGFloat(0.414)
        case .FSharp:
            return CGFloat(0.5)
        case .G:
            return CGFloat(0.562)
        case .AFlat:
            return CGFloat(0.669)
        case .A:
            return CGFloat(0.708)
        case .BFlat:
            return CGFloat(0.838)
        default:
            return CGFloat(0.854)
        }
    }
    
    static func y(note: Note) -> CGFloat {
        return CGFloat(0)
    }
}