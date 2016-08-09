//
//  Chord.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/13/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

class Chord : NSObject, NSCoding {
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
    
    required convenience init?(coder aDecoder: NSCoder) {
        let cTypeRawValue = aDecoder.decodeObjectForKey("ChordType") as? Int
        let cNotesRawValues = aDecoder.decodeObjectForKey("ChordNotes") as? [Int]
        let cType = ChordType(rawValue: cTypeRawValue!)
        let cNotes = cNotesRawValues!.map({rawVal in Note(rawValue: rawVal)!})
        
        self.init(notes: cNotes, chordType: cType!)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(chordType?.rawValue, forKey: "ChordType")
        aCoder.encodeObject(notes.map { note in note.rawValue }, forKey: "ChordNotes")
    }
}