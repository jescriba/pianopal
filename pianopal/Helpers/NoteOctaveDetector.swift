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
        let sortedButtons = pianoView.highlightedNoteButtons.sort({
            $0.superview!.convertPoint($0.frame.origin, toView: nil).x < $1.superview!.convertPoint($1.frame.origin, toView: nil).x
        })
        for noteButton in sortedButtons {
            if cgRectMostlyContainsRect(UIScreen.mainScreen().bounds, rect2: noteButton.superview!.convertRect(noteButton.frame, toView: nil)) {
                notes.append(NoteOctave(note: noteButton.note!, octave: noteButton.octave!))
            }
        }
        return notes
    }
    
    static func cgRectMostlyContainsRect(rect1: CGRect, rect2: CGRect) -> Bool {
        let midX = CGRectGetMidX(rect2)
        let midY = CGRectGetMidY(rect2)
        return CGRectContainsPoint(rect1, CGPointMake(midX, midY))
    }
}