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

    static func determineNoteOctavesOnScreen(_ pianoView: PianoView) -> [NoteOctave] {
        var notes = [NoteOctave]()
        let sortedButtons = pianoView.highlightedNoteButtons.sorted(by: {
            $0.superview!.convert($0.frame.origin, to: nil).x < $1.superview!.convert($1.frame.origin, to: nil).x
        })
        for noteButton in sortedButtons {
            if cgRectMostlyContainsRect(UIScreen.main.bounds, rect2: noteButton.superview!.convert(noteButton.frame, to: nil)) {
                notes.append(NoteOctave(note: noteButton.note!, octave: noteButton.octave!))
            }
        }
        return notes
    }
    
    static func cgRectMostlyContainsRect(_ rect1: CGRect, rect2: CGRect) -> Bool {
        let midX = rect2.midX
        let midY = rect2.midY
        return rect1.contains(CGPoint(x: midX, y: midY))
    }
}
