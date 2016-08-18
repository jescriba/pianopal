//
//  NoteOctave.swift
//  pianopal
//
//  Created by Joshua Escribano on 8/14/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

extension NoteOctave : Equatable {}
func ==(item1: NoteOctave, item2: NoteOctave) -> Bool {
    return item1.note! == item2.note! && item1.octave! == item2.octave!
}


class NoteOctave {
    var note: Note?
    var octave: Int?
    
    init(note: Note, octave: Int) {
        self.note = note
        self.octave = octave
    }
    
    func toString() -> String {
        return "\(note!.simpleDescription())\(octave!)"
    }
    
    func url() -> NSURL {
        let filePath = NSBundle.mainBundle().pathForResource("\(toString())", ofType: "mp3")
        return NSURL(fileURLWithPath: filePath!)
    }
}