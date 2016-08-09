//
//  Preferences.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/31/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

class Preferences {
    static var labelNoteNumber: Bool {
        get {
            return NSUserDefaults.standardUserDefaults().boolForKey("LabelNoteNumber") ?? false
        } set {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(newValue, forKey: "LabelNoteNumber")
        }
    }
    static var labelNoteLetter: Bool {
        get {
            return NSUserDefaults.standardUserDefaults().boolForKey("LabelNoteLetter") ?? false
        } set {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(newValue, forKey: "LabelNoteLetter")
        }
    }
    static var highlightTriads: Bool {
        get {
            return NSUserDefaults.standardUserDefaults().boolForKey("HighlightTriad") ?? false
        }
        set {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(newValue, forKey: "HighlightTriad")
        }
    }
}