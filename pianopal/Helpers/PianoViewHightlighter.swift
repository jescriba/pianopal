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
        // TODO
    }
    
    static func highlightScale(_ scale: Scale, pianoView: PianoView) {
        clearHighlighting(pianoView: pianoView)
        for noteButton in pianoView.noteButtons {
            label(noteButton: noteButton)
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
            label(noteButton: noteButton)
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
    
    static func label(noteButton: NoteButton) {
        // TODO
    }
    
    static func shiftTo(note: Note) {
        
    }
}
