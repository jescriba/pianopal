//
//  PianoSession.swift
//  pianopal
//
//  Created by Joshua Escribano on 9/18/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

class PianoSession : NSObject, NSCoding {
    var chords: [Chord]?
    var scales: [Scale]?
    
    init(chords: [Chord], scales: [Scale]) {
        self.chords = chords
        self.scales = scales
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(chords: [Chord](), scales: [Scale]())
    }
    
    func encode(with aCoder: NSCoder) {
        //
        aCoder.encode(chords, forKey: "Chords")
        aCoder.encode(scales, forKey: "Scales")
    }
    
//    required convenience init?(coder aDecoder: NSCoder) {
//        let cTypeRawValue = aDecoder.decodeObject(forKey: "ChordType") as? Int
//        let cNotesRawValues = aDecoder.decodeObject(forKey: "ChordNotes") as? [Int]
//        let cType = ChordType(rawValue: cTypeRawValue!)
//        let cNotes = cNotesRawValues!.map({rawVal in Note(rawValue: rawVal)!})
//        
//        self.init(notes: cNotes, chordType: cType!)
//    }
//    
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(chordType?.rawValue, forKey: "ChordType")
//        aCoder.encode(notes.map { note in note.rawValue }, forKey: "ChordNotes")
//    }
}
