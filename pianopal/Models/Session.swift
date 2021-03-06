//
//  PianoSession.swift
//  pianopal
//
//  Created by Joshua Escribano on 9/18/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

class Session : NSObject, NSCoding {
    var name: String! = ""
    var uid: String!
    var chords = [Chord]()
    var scales = [Scale]()
    
    override init() {
        super.init()
    }
    
    init(name: String) {
        super.init()
        
        self.uid = UUID().uuidString
        self.name = name
    }
    
    init(chords: [Chord], scales: [Scale], name: String = "", uid: String) {
        super.init()
        
        self.uid = UUID().uuidString
        self.name = name
        self.chords = chords
        self.scales = scales
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let chords = aDecoder.decodeObject(forKey: "Chords") as? [Chord] ?? [Chord]()
        let scales = aDecoder.decodeObject(forKey: "Scales") as? [Scale] ?? [Scale]()
        let name = aDecoder.decodeObject(forKey: "Name") as? String ?? SessionManager.sessionDateName()
        let uid = aDecoder.decodeObject(forKey: "Uid") as? String ?? UUID().uuidString
    
        self.init(chords: chords, scales: scales, name: name, uid: uid)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(chords, forKey: "Chords")
        aCoder.encode(scales, forKey: "Scales")
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(uid, forKey: "Uid")
    }

}
