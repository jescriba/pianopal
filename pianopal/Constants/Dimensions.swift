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
    static let toolBarHeight = UIScreen.main.bounds.height / 8
    static let toolBarWidth = UIScreen.main.bounds.width
    static let toolbarRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 8)
    static let pianoRect = CGRect(x: 0, y: UIScreen.main.bounds.height / 8, width: UIScreen.main.bounds.width, height: 7 * UIScreen.main.bounds.height / 8)
    static let pianoScrollRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 7 * UIScreen.main.bounds.height / 8)
    static let menuButtonRect = CGRect(x: 0, y: 0, width: 50, height: UIScreen.main.bounds.height / 8)
    static let playButtonRect = CGRect(x: UIScreen.main.bounds.width - 50, y: 0, width: 50, height: UIScreen.main.bounds.height / 8)
    static let rightBarButtonRect = CGRect(x: UIScreen.main.bounds.width - 50, y: 0, width: 50, height: UIScreen.main.bounds.height / 8)
    static let titleScrollViewRect = CGRect(x: 50, y: 0, width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 8)
}
