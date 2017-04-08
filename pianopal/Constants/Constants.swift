//
//  Constants.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/14/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

struct Constants {
    static let orderedNotes = [Note.c, Note.d, Note.e, Note.f, Note.g, Note.a, Note.b, Note.dFlat, Note.eFlat, Note.fSharp, Note.aFlat, Note.bFlat]
    static let orderedChordTypes = [ChordType.Major, ChordType.Minor, ChordType.Diminished, ChordType.Augmented, ChordType.Sus2, ChordType.Sus4, ChordType.MajorSeventh, ChordType.MinorSeventh, ChordType.DominantSeventh, ChordType.DiminishedSeventh, ChordType.HalfDiminishedSeventh]
    static let orderedScaleTypes = [ScaleType.Major, ScaleType.NaturalMinor, ScaleType.MelodicMinor, ScaleType.MinorPentatonic, ScaleType.HarmonicMajor, ScaleType.HarmonicMinor, ScaleType.HungarianMajor, ScaleType.HungarianMinor, ScaleType.BluesHexatonic]
    static let totalNotes = 12
    static let totalChordTypes = 11
    static let totalScaleTypes = 9
    static let totalModes = 7
}
