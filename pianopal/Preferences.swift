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
            if NSUserDefaults.standardUserDefaults().objectForKey("LabelNoteNumber") == nil {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: "LabelNoteNumber")
            }
            let pref = NSUserDefaults.standardUserDefaults().boolForKey("LabelNoteNumber")
            return pref
        } set {
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "LabelNoteNumber")
        }
    }
    static var labelNoteLetter: Bool {
        get {
            if NSUserDefaults.standardUserDefaults().objectForKey("LabelNoteLetter") == nil {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: "LabelNoteLetter")
            }
            let pref = NSUserDefaults.standardUserDefaults().boolForKey("LabelNoteLetter")
            return pref
        } set {
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "LabelNoteLetter")
        }
    }
    static var highlightTriads: Bool {
        get {
            if NSUserDefaults.standardUserDefaults().objectForKey("HighlightTriad") == nil {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: "HighlightTriad")
            }
            let pref = NSUserDefaults.standardUserDefaults().boolForKey("HighlightTriad")
            return pref
        }
        set {
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "HighlightTriad")
        }
    }
}