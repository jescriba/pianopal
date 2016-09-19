//
//  Scale.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/15/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

class Scale : NSObject, NSCoding {
    var notes =  [Note]()
    var scaleType: ScaleType?
    
    init(notes: [Note], scaleType: ScaleType) {
        self.notes = notes
        self.scaleType = scaleType
        
        super.init()
    }
    
    func indexOf(_ note: Note) -> Int? {
        return notes.index(of: note)
    }
    
    func simpleDescription() -> String {
        return "\(self.notes.first!.simpleDescription())\(self.scaleType!)"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let sTypeRawValue = aDecoder.decodeObject(forKey: "ScaleType") as? Int
        let sNotesRawValues = aDecoder.decodeObject(forKey: "ScaleNotes") as? [Int]
        let sType = ScaleType(rawValue: sTypeRawValue!)
        let sNotes = sNotesRawValues!.map({rawVal in Note(rawValue: rawVal)!})
        self.init(notes: sNotes, scaleType: sType!)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(scaleType?.rawValue, forKey: "ScaleType")
        aCoder.encode(notes.map{ note in note.rawValue}, forKey: "ScaleNotes")
    }

}
