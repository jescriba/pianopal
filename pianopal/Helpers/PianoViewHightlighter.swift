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
                let colors = PianoViewHightlighter.colors(noteButton: noteButton)
                DispatchQueue.main.async {
                    noteButton.illuminate(colors)
                }
            }
        }
        
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
    }
    
    static func clearHighlighting(pianoView: PianoView) {
        for noteButton in pianoView.highlightedNoteButtons {
            DispatchQueue.main.async(execute: {
                noteButton.deIlluminate()
            })
        }
        pianoView.highlightedNoteButtons.removeAll()
    }
    
    static func colors(noteButton: NoteButton) -> [KeyColorPair] {
        // TODO
        return [KeyColorPair]()
    }
    
    static func label(noteButton: NoteButton) {
        // TODO
    }
}
