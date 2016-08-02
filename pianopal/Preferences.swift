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
            let pref = NSUserDefaults.standardUserDefaults().boolForKey("LabelNoteNumber")
            if !pref {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: "LabelNoteNumber")
            }
            return pref
        } set {
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "LabelNoteNumber")
        }
    }
    static var labelNoteLetter: Bool {
        get {
            let pref = NSUserDefaults.standardUserDefaults().boolForKey("LabelNoteLetter")
            if !pref {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: "LabelNoteLetter")
            }
            return pref
        } set {
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "LabelNoteLetter")
        }
    }
    static var highlightTriads: Bool {
        get {
            let pref = NSUserDefaults.standardUserDefaults().boolForKey("HighlightTriad")
            if !pref {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "HighlightTriad")
            }
            return pref
        }
        set {
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "HighlightTriad")
        }
    }
}