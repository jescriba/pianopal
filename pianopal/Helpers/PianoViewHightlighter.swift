//
//  PianoViewHightlighter.swift
//  pianopal
//
//  Created by Joshua Escribano on 9/29/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

class PianoViewHightlighter {
    
    static func labelNotes(_ pianoView: PianoView) {
        for noteButton in pianoView.noteButtons {
            label(noteButton: noteButton)
        }
    }
    
    static func removeLabelNotes(pianoView: PianoView) {
        for noteButton in pianoView.noteButtons {
            noteButton.label("")
        }
    }
    
    static func highlightScale(_ scale: Scale, pianoView: PianoView) {
        clearHighlighting(pianoView: pianoView)
        for noteButton in pianoView.noteButtons {
            label(noteButton: noteButton, scale: scale)
            if scale.notes.contains(noteButton.note!) {
                pianoView.highlightedNoteButtons.append(noteButton)
                let colors = PianoViewHightlighter.colors(noteButton: noteButton, scale: scale)
                DispatchQueue.main.async {
                    noteButton.illuminate(colors)
                }
            }
        }
        shiftTo(note: scale.notes.first!)
    }
    
    static func highlightChord(_ chord: Chord, pianoView: PianoView) {
        clearHighlighting(pianoView: pianoView)
        for noteButton in pianoView.noteButtons {
            label(noteButton: noteButton, chord: chord)
            if chord.notes.contains(noteButton.note!) {
                pianoView.highlightedNoteButtons.append(noteButton)
                DispatchQueue.main.async(execute: {
                    noteButton.illuminate([KeyColorPair(whiteKeyColor: Colors.highlightedWhiteKey, blackKeyColor: Colors.highlightedBlackKey)])
                })
            }
        }
        shiftTo(note: chord.notes.first!)
    }
    
    static func clearHighlighting(pianoView: PianoView) {
        for noteButton in pianoView.highlightedNoteButtons {
            DispatchQueue.main.async(execute: {
                noteButton.deIlluminate()
            })
        }
        pianoView.highlightedNoteButtons.removeAll()
    }
    
    static func colors(noteButton: NoteButton, scale: Scale) -> [KeyColorPair] {
        if Preferences.highlightTriads {
            let index = scale.indexOf(noteButton.note!)
            if index == nil {
                return [KeyColorPair(whiteKeyColor: Colors.highlightedWhiteKey, blackKeyColor: Colors.highlightedBlackKey)]
            }
            // 0, 2, 4
            // 1, 3, 5
            // 2, 4, 6
            // 3, 5, 0
            // 4, 6, 1
            // 5, 0, 2
            // 6, 1, 3
            var colors = [KeyColorPair]()
            if ([0, 2, 4].contains(index!)) {
                colors.append(Colors.triads[0])
            }
            if ([1, 3, 5].contains(index!)) {
                colors.append(Colors.triads[1])
            }
            if ([2, 4, 6].contains(index!)) {
                colors.append(Colors.triads[2])
            }
            if ([3, 5, 0].contains(index!)) {
                colors.append(Colors.triads[3])
            }
            if ([4, 6, 1].contains(index!)) {
                colors.append(Colors.triads[4])
            }
            if ([5, 0, 2].contains(index!)) {
                colors.append(Colors.triads[5])
            }
            if ([6, 1, 3].contains(index!)) {
                colors.append(Colors.triads[6])
            }
            return colors
        }
        return [KeyColorPair(whiteKeyColor: Colors.highlightedWhiteKey, blackKeyColor: Colors.highlightedBlackKey)]

    }
    
    static func label(noteButton: NoteButton, chord: Chord? = nil, scale: Scale? = nil) {
        var title = ""
        if Preferences.labelNoteLetter {
            title = (noteButton.note?.simpleDescription())!
        }
        if Preferences.labelNoteNumber {
            let chordIndex = chord?.indexOf(noteButton.note!)
            if (chord != nil && chordIndex != nil) {
                title += LabelHelper.intervalNumberAsString(noteButton.note!, rootNote: chord!.notes[0])
            }
            let scaleIndex = scale?.indexOf(noteButton.note!)
            if (scale != nil && scaleIndex != nil) {
                title += String(scaleIndex! + 1)
            }
        }
        noteButton.label(title)
    }
    
    static func shiftTo(note: Note) {
        // TODO
    }
}
