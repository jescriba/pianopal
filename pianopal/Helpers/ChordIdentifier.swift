//
//  ChordIdentifier.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/16/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

class ChordIdentifier {
    static func chordForNotes(_ notes: [Note]) -> Chord? {
        let uniqueNotes = Array(Set(notes))
        if uniqueNotes.count == 3 || uniqueNotes.count == 4 {
            let sortedNotes = uniqueNotes.sorted(by: { (a, b) -> Bool in
                a.rawValue < b.rawValue
            })
            let possibleIntervals = calculateIntervals(sortedNotes)
            for (rootNote, intervals) in possibleIntervals {
                for i in 0...(Constants.totalChordTypes - 1) {
                    let chordType = ChordType(rawValue: i)
                    if intervals.elementsEqual(chordType!.chordFormula()) {
                        return ChordGenerator.generateChord(rootNote, chordType: chordType!)
                    }
                }
            }
        }
        return nil
    }
    
    static func calculateIntervals(_ notes: [Note]) -> [Note:[Int]] {
        var possibleIntervalsList = [Note:[Int]]()
        var noteValuesToCheck = notes.map({$0.rawValue})
        var rootNoteValue = noteValuesToCheck[0]
        for i in 0...(notes.count - 1) {
            var intervals = [Int]()
            noteValuesToCheck.removeFirst()
            for noteValue in noteValuesToCheck {
                intervals.append(abs(rootNoteValue - noteValue))
            }
            possibleIntervalsList[notes[i]] = intervals
            rootNoteValue += 12
            noteValuesToCheck.append(rootNoteValue)
            rootNoteValue = noteValuesToCheck.first!
        }
        return possibleIntervalsList
    }
}
