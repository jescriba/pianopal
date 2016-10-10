//
//  Globals.swift
//  pianopal
//
//  Created by Joshua Escribano on 10/2/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

class Globals {
    static var chords: [Chord] {
        get {
            return session?.chords ?? [Chord]()
        }
    }
    static var scales: [Scale] {
        get {
            return session?.scales ?? [Scale]()
        }
    }
    static var session: Session? {
        get {
            return sessions.first
        }
    }
    static var sessions =  [Session]()
}
