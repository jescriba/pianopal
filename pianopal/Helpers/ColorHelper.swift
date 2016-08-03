//
//  ColorHelper.swift
//  pianopal
//
//  Created by Joshua Escribano on 8/3/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class ColorHelper {
    static func triadColors(triadIndex: Int) -> KeyColorPair {
        let red = CGFloat(Double(triadIndex) * 0.16 + 0.2)
        let blue = CGFloat(Double(triadIndex) * 0.04 + 0.14)
        let green = CGFloat(Double(triadIndex) * 0.07 + 0.07)
        let whiteKeyColor = changeHueForColor(red, newGreen: green, newBlue: blue, color: Colors.highlightedWhiteKeyColor)
        let blackKeyColor = changeHueForColor(red, newGreen: green, newBlue: blue,
                                              color: Colors.highlightedBlackKeyColor)
        return KeyColorPair(whiteKeyColor: whiteKeyColor, blackKeyColor: blackKeyColor)
    }
    
    static func changeHueForColor(newRed: CGFloat?, newGreen: CGFloat?, newBlue: CGFloat?, color: UIColor) -> UIColor {
        var red: CGFloat = 0
        var blue: CGFloat = 0
        var green: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let finalRed = (newRed ?? red) / 1
        let finalBlue = (newBlue ?? blue) / 1
        let finalGreen = (newGreen ?? green) / 1
        return UIColor(red: finalRed, green: finalGreen, blue: finalBlue, alpha: alpha)
    }
}