//
//  Colors.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/26/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class Colors {
    static let keyBorder = UIColor(red: 0.90, green: 0.90, blue: 1.0, alpha: 1).CGColor
    static let highlightedKeyBorder = UIColor(red:1, green:0.54, blue:0.90, alpha:1.0).CGColor
    static let toolBarBackground = UIColor(red: 0.94, green: 0.86, blue: 1, alpha: 1)
    static let toolbarActionText = UIColor(red: 0.94, green: 0.86, blue: 1, alpha: 1)
    static let changeToolbarActionText = UIColor(red: 1, green: 0.3, blue: 0.3, alpha: 1)
    static let pickerBackground = UIColor(red: 1, green: 0.92, blue: 0.81, alpha: 1)
    static let highlightedWhiteKeyColor = UIColor(red: 0.0, green: 0.6, blue: 0.8, alpha: 1)
    static let highlightedBlackKeyColor = UIColor(red: 0.0, green: 0.5, blue: 0.75, alpha: 1)
    static let normalRightBarButtonColor = UIColor(red: 0.0, green: 0.6, blue: 0.8, alpha: 1)
    static let pressedRightBarButtonColor = UIColor(red: 0.0, green: 0.4, blue: 0.98, alpha: 1)
    static let normalMenuButtonColor = UIColor(red: 0.0, green: 0.6, blue: 0.8, alpha: 1)
    static let presssedMenuButtonColor = UIColor(red: 0.0, green: 0.4, blue: 0.98, alpha: 1)
    static let normalPlayButtonColor = UIColor(red: 0.2, green: 0.7, blue: 0.8, alpha: 1)
    static let pressedPlayButtonColor = UIColor(red: 0.2, green: 0.5, blue: 0.98, alpha: 1)
    static let navigationTablViewCellSelectedBackgroundColor = UIColor(red: 1, green: 0.80, blue: 0.9, alpha: 1)
    static let chordTableSeparatorColor = UIColor(red: 0.9, green: 0.80, blue: 0.9, alpha: 1)
    static let chordTableBackgroundColor = UIColor(red: 1, green: 0.92, blue: 0.81, alpha: 1)
    static let tableViewCellSelectedColor = UIColor(red: 1, green: 0.82, blue: 0.81, alpha: 1)
    static let slideMenuBackgroundColor =  UIColor(red: 0.94, green: 0.84, blue: 0.97, alpha: 1)
    static let settingsSwitchTintColor = UIColor(red: 0.93, green: 0.55, blue: 0.72, alpha: 1)
    static let triadColors = [KeyColorPair(whiteKeyColor: UIColor(red: 0.7, green: 0.41, blue: 0.44, alpha: 1), blackKeyColor: UIColor(red: 0.7, green: 0.3, blue: 0.40, alpha: 1)),
                              KeyColorPair(whiteKeyColor: UIColor(red: 0.42, green: 0.50, blue: 0.89, alpha: 1), blackKeyColor: UIColor(red: 0.42, green: 0.40, blue: 0.84, alpha: 1)),
                              KeyColorPair(whiteKeyColor: UIColor(red: 0.47, green: 0.89, blue: 0.49, alpha: 1), blackKeyColor: UIColor(red: 0.47, green: 0.79, blue: 0.44, alpha: 1)),
                              KeyColorPair(whiteKeyColor: UIColor(red: 0.9, green: 0.84, blue: 0.63, alpha: 1), blackKeyColor: UIColor(red: 0.9, green: 0.74, blue: 0.59, alpha: 1)),
                              KeyColorPair(whiteKeyColor: UIColor(red: 1, green: 0.58, blue: 0.53, alpha: 1), blackKeyColor: UIColor(red: 1, green: 0.48, blue: 0.49, alpha: 1)),
                              KeyColorPair(whiteKeyColor: UIColor(red: 0.74, green: 0.6, blue: 0.91, alpha: 1), blackKeyColor: UIColor(red: 0.74, green: 0.5, blue: 0.86, alpha: 1)),
                              KeyColorPair(whiteKeyColor: UIColor(red:0.51, green:0.88, blue:0.90, alpha:1.0), blackKeyColor: UIColor(red:0.51, green:0.78, blue:0.85, alpha:1.0))]
}