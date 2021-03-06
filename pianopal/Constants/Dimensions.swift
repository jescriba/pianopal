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
    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
    static let toolBarWidth = UIScreen.main.bounds.width
    static let toolbarRect = CGRect(x: 0, y: statusBarHeight, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 8)
    static let pianoRect = CGRect(x: 0, y: UIScreen.main.bounds.height / 8, width: UIScreen.main.bounds.width, height: 7 * UIScreen.main.bounds.height / 8)
    static let pianoScrollRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 7 * UIScreen.main.bounds.height / 8)
    static let menuButtonRect = CGRect(x: 0, y: 0, width: 50, height: UIScreen.main.bounds.height / 8)
    static let playButtonRect = CGRect(x: UIScreen.main.bounds.width - 50, y: 0, width: 50, height: UIScreen.main.bounds.height / 8)
    static let leftRightBarButtonRect = CGRect(x: UIScreen.main.bounds.width - 110, y: 0, width: 50, height: UIScreen.main.bounds.height / 8)
    static let rightBarButtonRect = CGRect(x: UIScreen.main.bounds.width - 50, y: 0, width: 50, height: UIScreen.main.bounds.height / 8)
    static let innerRightBarButtonRect = CGRect(x: UIScreen.main.bounds.width - 50, y: 0, width: 50, height: UIScreen.main.bounds.height / 8)
    static let titleScrollViewRect = CGRect(x: 50, y: 0, width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 8)
    static let saveBoxRect = CGRect(x: UIScreen.main.bounds.width - 200, y: 0, width: 200, height: UIScreen.main.bounds.height / 10)
    static let addChordRowButton = CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 90)
}
