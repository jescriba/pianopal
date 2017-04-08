//
//  Key.swift
//  pianopal
//
//  Created by Joshua Escribano on 4/2/17.
//  Copyright © 2017 Joshua Escribano. All rights reserved.
//

import Foundation

class Key {
    var keyType: KeyType!
    var rootNote: Note?
    var chords: [Chord] {
        get {
            var tempChords = [Chord]()
            var notes = [Note]()
            if keyType == KeyType.major {
                let scale = ScaleGenerator.generateScale(rootNote ?? .c, scaleType: .Major)
                notes = scale.notes
            } else {
                let scale = ScaleGenerator.generateScale(rootNote ?? .c, scaleType: .NaturalMinor)
                notes = scale.notes
            }
            
            for i in 0...(notes.count - 1) {
                tempChords.append(ChordGenerator.generateChord(notes[i], chordType: chordTypes[i]))
            }
            
            return tempChords
        }
    }
    var notes: [Note] {
        get {
            var tempNotes = [Note]()
            for chord in chords {
                tempNotes.append(chord.notes.first!)
            }
            return tempNotes
        }
    }
    var chordTypes: [ChordType] {
        get {
            if keyType == KeyType.major {
                return [ChordType.Major, ChordType.Minor, ChordType.Minor, ChordType.Major, ChordType.Major, ChordType.Minor, ChordType.Diminished]
            } else if keyType == KeyType.minor {
                return [ChordType.Minor, ChordType.Major, ChordType.Major, ChordType.Minor, ChordType.Minor, ChordType.Major, ChordType.Diminished]
            }
            return Constants.orderedChordTypes
        }
    }
    var isSet: Bool {
        get {
            return keyType != KeyType.unset && rootNote != nil
        }
    }
    init(rootNote: Note? = nil, keyType: KeyType? = nil) {
        self.rootNote = rootNote
        self.keyType = keyType ?? KeyType.unset
    }
    
    func chordTypesFor(note: Note) -> [ChordType] {
        //TODO Consider expanding chord compability
        if !isSet {
            return Constants.orderedChordTypes
        }
        let noteIndex = notes.index(of: note) ?? 0
        return [chords[noteIndex].chordType ?? .MajorSeventh]
    }
}
