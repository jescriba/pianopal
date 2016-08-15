//
//  NoteOctaveDetector.swift
//  pianopal
//
//  Created by Joshua Escribano on 8/14/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class NoteOctaveDetector {

    static func determineNoteOctavesOnScreen(pianoView: PianoView) -> [NoteOctave] {
        var notes = [NoteOctave]()
        for noteButton in pianoView.highlightedNoteButtons {
            if CGRectContainsRect(UIScreen.mainScreen().bounds, noteButton.convertRect(noteButton.frame, toView: nil)) {
                notes.append(NoteOctave(note: noteButton.note!, octave: noteButton.octave!))
            }
        }
        return notes
    }
}