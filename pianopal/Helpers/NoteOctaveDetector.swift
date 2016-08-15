//
//  NoteOctaveDetector.swift
//  pianopal
//
//  Created by Joshua Escribano on 8/14/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

class NoteOctaveDetector {

    static func determineNoteOctavesOnScreen(pianoView: PianoView) -> [NoteOctave] {
        // TODO: Determine NoteOctaves on the screen
        
        var notes = [NoteOctave]()
        notes.append(NoteOctave(note: Note(rawValue: 4)!, octave: 4))
        notes.append(NoteOctave(note: Note(rawValue: 6)!, octave: 4))
        notes.append(NoteOctave(note: Note(rawValue: 8)!, octave: 4))
        notes.append(NoteOctave(note: Note(rawValue: 9)!, octave: 4))
        notes.append(NoteOctave(note: Note(rawValue: 11)!, octave: 4))
        return notes
    }
}