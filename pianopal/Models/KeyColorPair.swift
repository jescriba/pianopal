//
//  KeyColorPair.swift
//  pianopal
//
//  Created by Joshua Escribano on 8/3/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

struct KeyColorPair {
    var whiteKeyColor: UIColor?
    var blackKeyColor: UIColor?
    
    init(whiteKeyColor: UIColor, blackKeyColor: UIColor) {
        self.whiteKeyColor = whiteKeyColor
        self.blackKeyColor = blackKeyColor
    }
}