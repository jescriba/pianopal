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
    
    static func width(_ note: Note) -> CGFloat {
        switch note {
        case .dFlat, .eFlat, .fSharp, .aFlat, .bFlat:
            return CGFloat(0.077)
        case .d, .e, .c:
            return CGFloat(0.138)
        case .f:
            return CGFloat(0.148)
        default:
            return CGFloat(0.146)
        }
    }
    
    static func height(_ note: Note) -> CGFloat {
        if note.isBlackKey() {
            return CGFloat(0.64)
        }
        return CGFloat(1)
    }
    
    static func x(_ note: Note) -> CGFloat {
        switch note {
        case .c:
            return CGFloat(0)
        case .dFlat:
            return CGFloat(0.085)
        case .d:
            return CGFloat(0.138)
        case .eFlat:
            return CGFloat(0.254)
        case .e:
            return CGFloat(0.276)
        case .f:
            return CGFloat(0.414)
        case .fSharp:
            return CGFloat(0.5)
        case .g:
            return CGFloat(0.562)
        case .aFlat:
            return CGFloat(0.669)
        case .a:
            return CGFloat(0.708)
        case .bFlat:
            return CGFloat(0.838)
        default:
            return CGFloat(0.854)
        }
    }
    
    static func y(_ note: Note) -> CGFloat {
        return CGFloat(0)
    }
}
