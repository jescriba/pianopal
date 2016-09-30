//
//  NoteButton.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/13/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class NoteButton: UIButton {
    fileprivate var _note: Note?
    var note: Note? {
        get {
            return _note
        } set {
            _note = newValue
            noteOctave?.note = newValue
        }
    }
    fileprivate var _octave: Int?
    var octave: Int? {
        get {
            return _octave
        } set {
            _octave = newValue
            noteOctave?.octave = newValue
        }
    }
    var noteOctave: NoteOctave?
    var gradient: CAGradientLayer = CAGradientLayer()
    var illuminated = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, note: Note, octave: Int) {
        super.init(frame: frame)
        self.note = note
        self.octave = octave
        self.noteOctave = NoteOctave(note: note, octave: octave)
        self.backgroundColor = determineNoteColor(note)
        self.layer.borderWidth = 1
        self.layer.borderColor = Colors.keyBorder
    }
    
    func determineNoteColor(_ note: Note) -> UIColor {
        if note.isWhiteKey() {
            return UIColor.white
        }
        return UIColor.black
    }
    
    func illuminate(_ colorPairs: [KeyColorPair]) {
        gradient.removeFromSuperlayer()
        if colorPairs.count == 1 {
            let whiteKeyColor = colorPairs[0].whiteKeyColor!
            let blackKeyColor = colorPairs[0].blackKeyColor!
            if (self.note!.isWhiteKey()) {
                self.backgroundColor = whiteKeyColor
            } else {
                self.backgroundColor = blackKeyColor
            }
        } else {
            gradient.frame = self.bounds
            gradient.colors = []
            gradient.locations = [0]
            if (self.note!.isWhiteKey()) {
                for (index, colorPair) in colorPairs.enumerated() {
                    gradient.colors!.append(colorPair.whiteKeyColor!.cgColor)
                    gradient.colors!.append(colorPair.whiteKeyColor!.cgColor)
                    gradient.locations!.append(Double(index + 1)/Double(colorPairs.count) as NSNumber)
                    gradient.locations!.append(Double(index + 1)/Double(colorPairs.count) as NSNumber)
                }
            } else {
                for (index, colorPair) in colorPairs.enumerated() {
                    gradient.colors!.append(colorPair.blackKeyColor!.cgColor)
                    gradient.colors!.append(colorPair.blackKeyColor!.cgColor)
                    gradient.locations!.append(Double(index + 1)/Double(colorPairs.count) as NSNumber)
                    gradient.locations!.append(Double(index + 1)/Double(colorPairs.count) as NSNumber)
                }
            }
            gradient.locations!.append(1.0)
            
            self.layer.insertSublayer(gradient, at: 0)
        }
        illuminated = true
    }
    
    func deIlluminate() {
        gradient.removeFromSuperlayer()
        self.backgroundColor = determineNoteColor(note!)
        illuminated = false
    }
    
    func highlightBorder() {
        layer.borderColor = Colors.highlightedKeyBorder
        layer.shadowRadius = 7.0
        layer.shadowOpacity = 1
        layer.borderWidth = 5
    }
    
    func dehighlightBorder() {
        layer.borderColor = Colors.keyBorder
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0
        layer.borderWidth = 1
    }
    
    func label(_ label: String?) {
        var description = label
        if (description == nil) {
            description = note!.simpleDescription()
        }
        self.setTitle(description, for: UIControlState())
        if note!.isWhiteKey() {
            self.setTitleColor(UIColor.black, for: UIControlState())
        }
    }
}
