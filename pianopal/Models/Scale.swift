//
//  Scale.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/15/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

class Scale : NSObject, NSCoding {
    var rootNote: Note!
    var notes =  [Note]()
    var scaleType: ScaleType?
    var mode: Mode {
        willSet {
            let rootIndex = notes.index(of: rootNote) ?? 0
            let newStartingIndex = (rootIndex + newValue.rawValue) % notes.count
            // shift notes array according to mode
            var tempNotes = notes
            for i in 0...(notes.count - 1) {
                tempNotes[i] = notes[(i + newStartingIndex) % notes.count]
            }
            notes = tempNotes
        }
    }
    
    init(notes: [Note], scaleType: ScaleType, rootNote: Note? = nil) {
        self.notes = notes
        self.rootNote = rootNote ?? notes.first
        self.scaleType = scaleType
        self.mode = .ionian
        
        super.init()
    }
    
    func indexOf(_ note: Note) -> Int? {
        return notes.index(of: note)
    }
    
    func simpleDescription() -> String {
        return "\(self.rootNote.simpleDescription())\(self.scaleType!)"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let sTypeRawValue = aDecoder.decodeObject(forKey: "ScaleType") as? Int
        let sNotesRawValues = aDecoder.decodeObject(forKey: "ScaleNotes") as? [Int]
        let sType = ScaleType(rawValue: sTypeRawValue!)
        let sNotes = sNotesRawValues!.map({rawVal in Note(rawValue: rawVal)!})
        self.init(notes: sNotes, scaleType: sType!)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(scaleType?.rawValue, forKey: "ScaleType")
        aCoder.encode(notes.map{ note in note.rawValue}, forKey: "ScaleNotes")
    }

}
