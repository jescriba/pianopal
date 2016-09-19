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
    
    func indexOf(_ note: Note) -> Int? {
        return notes.index(of: note)
    }
    
    func simpleDescription() -> String {
        return "\(self.notes.first!.simpleDescription())\(self.chordType!)"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let cTypeRawValue = aDecoder.decodeObject(forKey: "ChordType") as? Int
        let cNotesRawValues = aDecoder.decodeObject(forKey: "ChordNotes") as? [Int]
        let cType = ChordType(rawValue: cTypeRawValue!)
        let cNotes = cNotesRawValues!.map({rawVal in Note(rawValue: rawVal)!})
        
        self.init(notes: cNotes, chordType: cType!)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(chordType?.rawValue, forKey: "ChordType")
        aCoder.encode(notes.map { note in note.rawValue }, forKey: "ChordNotes")
    }
}
