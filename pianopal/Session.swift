//
//  Session.swift
//  pianopal
//
//  Created by Joshua Escribano on 8/6/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

class Session {
    static func save(scales: [Scale]? = nil, chords: [Chord]? = nil) {
        if scales != nil {
            let data = NSKeyedArchiver.archivedDataWithRootObject(scales!)
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "Scales")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        if chords != nil {
            let data = NSKeyedArchiver.archivedDataWithRootObject(chords!)
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "Chords")
        }
    }
    
    static func loadScales() -> [Scale]? {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("Scales") as? NSData {
            let scales = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [Scale]
            return scales
        }

        return nil
    }
    
    static func loadChords() -> [Chord]? {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("Chords") as? NSData {
            let chords = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [Chord]
            return chords
        }
        
        return nil
    }
}