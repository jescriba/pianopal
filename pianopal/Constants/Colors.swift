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
    static let keyBorder = UIColor(red: 0.90, green: 0.90, blue: 1.0, alpha: 1).cgColor
    static let highlightedKeyBorder = UIColor(red:1, green:0.54, blue:0.90, alpha:1.0).cgColor
    static let toolBarBackground = UIColor(red: 0.94, green: 0.86, blue: 1, alpha: 1)
    static let toolbarTitle = UIColor(red: 0.94, green: 0.86, blue: 1, alpha: 1)
    static let pickerBackground = UIColor(red:1.00, green:0.92, blue:0.93, alpha:1.0)
    static let highlightedWhiteKey = UIColor(red: 0.0, green: 0.6, blue: 0.8, alpha: 1)
    static let highlightedBlackKey = UIColor(red: 0.0, green: 0.5, blue: 0.75, alpha: 1)
    static let normalRightBarButton = UIColor(red: 0.0, green: 0.6, blue: 0.8, alpha: 1)
    static let pressedRightBarButton = UIColor(red: 0.0, green: 0.4, blue: 0.98, alpha: 1)
    static let normalMenuButton = UIColor(red: 0.0, green: 0.6, blue: 0.8, alpha: 1)
    static let presssedMenuButton = UIColor(red: 0.0, green: 0.4, blue: 0.98, alpha: 1)
    static let normalPlayButton = UIColor(red: 0.2, green: 0.7, blue: 0.8, alpha: 1)
    static let pressedPlayButton = UIColor(red: 0.2, green: 0.5, blue: 0.98, alpha: 1)
    static let navigationText = UIColor.black
    static let navigationBackground =  UIColor(red: 0.94, green: 0.84, blue: 0.97, alpha: 1)
    static let navigationSeparator = UIColor(red: 0.88, green: 0.70, blue: 0.98, alpha: 1)
    static let navigationCellSelectedBackground = UIColor(red: 1, green: 0.80, blue: 0.9, alpha: 1)
    static let tableSeparator = UIColor(red: 0.9, green: 0.80, blue: 0.9, alpha: 1)
    static let tableBackground = UIColor(red:1.00, green:0.92, blue:0.93, alpha:1.0)
    static let tableCellSelected = UIColor(red:1.00, green:0.82, blue:0.83, alpha:1.0)
    static let settingsSwitchTint = UIColor(red: 0.93, green: 0.55, blue: 0.72, alpha: 1)
    static let triads = [KeyColorPair(whiteKeyColor: UIColor(red: 0.7, green: 0.41, blue: 0.44, alpha: 1), blackKeyColor: UIColor(red: 0.7, green: 0.3, blue: 0.40, alpha: 1)),
                              KeyColorPair(whiteKeyColor: UIColor(red: 0.42, green: 0.50, blue: 0.89, alpha: 1), blackKeyColor: UIColor(red: 0.42, green: 0.40, blue: 0.84, alpha: 1)),
                              KeyColorPair(whiteKeyColor: UIColor(red: 0.47, green: 0.89, blue: 0.49, alpha: 1), blackKeyColor: UIColor(red: 0.47, green: 0.79, blue: 0.44, alpha: 1)),
                              KeyColorPair(whiteKeyColor: UIColor(red: 0.9, green: 0.84, blue: 0.63, alpha: 1), blackKeyColor: UIColor(red: 0.9, green: 0.74, blue: 0.59, alpha: 1)),
                              KeyColorPair(whiteKeyColor: UIColor(red: 1, green: 0.58, blue: 0.53, alpha: 1), blackKeyColor: UIColor(red: 1, green: 0.48, blue: 0.49, alpha: 1)),
                              KeyColorPair(whiteKeyColor: UIColor(red: 0.74, green: 0.6, blue: 0.91, alpha: 1), blackKeyColor: UIColor(red: 0.74, green: 0.5, blue: 0.86, alpha: 1)),
                              KeyColorPair(whiteKeyColor: UIColor(red:0.51, green:0.88, blue:0.90, alpha:1.0), blackKeyColor: UIColor(red:0.51, green:0.78, blue:0.85, alpha:1.0))]
}
