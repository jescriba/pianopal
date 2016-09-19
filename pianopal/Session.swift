//
//  Session.swift
//  pianopal
//
//  Created by Joshua Escribano on 8/6/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

class Session {
    static func save(_ scales: [Scale]? = nil, chords: [Chord]? = nil) {
        if scales != nil {
            let data = NSKeyedArchiver.archivedData(withRootObject: scales!)
            UserDefaults.standard.set(data, forKey: "Scales")
            UserDefaults.standard.synchronize()
        }
        if chords != nil {
            let data = NSKeyedArchiver.archivedData(withRootObject: chords!)
            UserDefaults.standard.set(data, forKey: "Chords")
        }
    }
    
    static func loadScales() -> [Scale]? {
        if let data = UserDefaults.standard.object(forKey: "Scales") as? Data {
            let scales = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Scale]
            return scales
        }

        return nil
    }
    
    static func loadChords() -> [Chord]? {
        if let data = UserDefaults.standard.object(forKey: "Chords") as? Data {
            let chords = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Chord]
            return chords
        }
        
        return nil
    }
}
