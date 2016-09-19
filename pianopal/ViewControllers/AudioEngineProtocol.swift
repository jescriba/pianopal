//
//  AudioEngineProtocol.swift
//  pianopal
//
//  Created by Joshua Escribano on 8/15/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

protocol AudioEngineDelegate : class {
    func didFinishPlaying()
    func didFinishPlayingNotes(_ notes: [NoteOctave])
    func didStartPlayingNotes(_ notes: [NoteOctave])
}
