//
//  PianoSession.swift
//  pianopal
//
//  Created by Joshua Escribano on 9/18/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

class PianoSession : NSObject, NSCoding {
    var chords: [Chord]?
    var scales: [Scale]?
    
    init(chords: [Chord], scales: [Scale]) {
        self.chords = chords
        self.scales = scales
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(chords: [Chord](), scales: [Scale]())
    }
    
    func encode(with aCoder: NSCoder) {
        //
    }
}
