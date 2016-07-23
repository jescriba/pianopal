//
//  Dimensions.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/22/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//
import UIKit
import Foundation

struct Dimensions {
    static let toolBarHeight = UIScreen.mainScreen().bounds.height / 8
    static let toolBarWidth = UIScreen.mainScreen().bounds.width
    static let toolbarRect = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height / 8)
    static let pianoRect = CGRect(x: 0, y: UIScreen.mainScreen().bounds.height / 8, width: UIScreen.mainScreen().bounds.width, height: 7 * UIScreen.mainScreen().bounds.height / 8)
    static let menuButtonRect = CGRect(x: 0, y: 0, width: 50, height: UIScreen.mainScreen().bounds.height / 8)
    static let changeModeButtonRect = CGRect(x: UIScreen.mainScreen().bounds.width - 50, y: 0, width: 50, height: UIScreen.mainScreen().bounds.height / 8)
}