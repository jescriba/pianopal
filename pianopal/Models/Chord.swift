//
//  Chord.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/13/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

struct Chord {
    var notes =  [Note]()
    var chordType: ChordType?
    
    init(notes: [Note], chordType: ChordType) {
        self.notes = notes
        self.chordType = chordType
    }
    
    func indexOf(note: Note) -> Int? {
        return notes.indexOf(note)
    }
    
    func simpleDescription() -> String {
        return "\(self.notes.first!.simpleDescription())\(self.chordType!)"
    }
}