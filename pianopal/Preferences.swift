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
            return UserDefaults.standard.bool(forKey: "LabelNoteNumber")
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "LabelNoteNumber")
        }
    }
    static var labelNoteLetter: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "LabelNoteLetter")
        } set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "LabelNoteLetter")
        }
    }
    static var highlightTriads: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "HighlightTriad")
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "HighlightTriad")
        }
    }
    static var autoPlayProgression: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "AutoPlayProgression")
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "AutoPlayProgression")
        }
    }
}
