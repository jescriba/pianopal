//
//  NoteButton.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/13/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class NoteButton: UIButton {
    var note: Note?
    var octave: Int?
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
    
    func determineNoteColor(note: Note) -> UIColor {
        if note.isWhiteKey() {
            return UIColor.whiteColor()
        }
        return UIColor.blackColor()
    }
    
    func illuminate(colorPairs: [KeyColorPair]) {
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
                for (index, colorPair) in colorPairs.enumerate() {
                    gradient.colors!.append(colorPair.whiteKeyColor!.CGColor)
                    gradient.colors!.append(colorPair.whiteKeyColor!.CGColor)
                    gradient.locations!.append(Double(index + 1)/Double(colorPairs.count))
                    gradient.locations!.append(Double(index + 1)/Double(colorPairs.count))
                }
            } else {
                for (index, colorPair) in colorPairs.enumerate() {
                    gradient.colors!.append(colorPair.blackKeyColor!.CGColor)
                    gradient.colors!.append(colorPair.blackKeyColor!.CGColor)
                    gradient.locations!.append(Double(index + 1)/Double(colorPairs.count))
                    gradient.locations!.append(Double(index + 1)/Double(colorPairs.count))
                }
            }
            gradient.locations!.append(1.0)
            
            self.layer.insertSublayer(gradient, atIndex: 0)
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
        layer.borderWidth = 5
    }
    
    func dehighlightBorder() {
        layer.borderColor = Colors.keyBorder
        layer.borderWidth = 1
    }
    
    func label(label: String?) {
        var description = label
        if (description == nil) {
            description = note!.simpleDescription()
        }
        self.setTitle(description, forState: UIControlState.Normal)
        if note!.isWhiteKey() {
            self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        }
    }
}
