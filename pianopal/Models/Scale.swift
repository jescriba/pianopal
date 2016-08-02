//
//  Scale.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/15/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

struct Scale {
    var notes =  [Note]()
    var scaleType: ScaleType?
    
    init(notes: [Note], scaleType: ScaleType) {
        self.notes = notes
        self.scaleType = scaleType
    }
    
    func indexOf(note: Note) -> Int? {
        return notes.indexOf(note)
    }
    
    func simpleDescription() -> String {
        return "\(self.notes.first!.simpleDescription())\(self.scaleType!)"
    }

}