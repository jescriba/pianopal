//
//  ChordGenerator.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/13/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

class ChordGenerator {
    static func generateChord(_ rootNote: Note, chordType: ChordType) -> Chord {
        var notes = [Note]()
        notes.append(rootNote)
        for interval in chordType.chordFormula() {
            notes.append(Note(rawValue: (rootNote.rawValue + interval) % 12)!)
        }
        return Chord(notes: notes, chordType: chordType)
    }
}
