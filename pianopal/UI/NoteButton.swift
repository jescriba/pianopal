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
    var illuminated = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, note: Note) {
        super.init(frame: frame)
        self.note = note
//        self.setTitle(note.simpleDescription(), forState: UIControlState.Normal)
//        if note.isWhiteKey() {
//            self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//        }
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
    
    func illuminate() {
        if (self.note!.isWhiteKey()) {
            self.backgroundColor = Colors.highlightedWhiteKeyColor
        } else {
            self.backgroundColor = Colors.highlightedBlackKeyColor
        }
        illuminated = true
    }
    
    func deIlluminate() {
        self.backgroundColor = determineNoteColor(note!)
        illuminated = false
    }
}
