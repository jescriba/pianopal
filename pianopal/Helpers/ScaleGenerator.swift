//
//  ScaleGenerator.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/13/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

class ScaleGenerator {
    static func generateScale(rootNote: Note, scaleType: ScaleType) -> Scale {
        var notes = [Note]()
        notes.append(rootNote)
        for interval in scaleType.scaleFormula() {
            notes.append(Note(rawValue: (rootNote.rawValue + interval) % 12)!)
        }
        return Scale(notes: notes, scaleType: scaleType)
    }
}