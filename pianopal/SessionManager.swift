//
//  Session.swift
//  pianopal
//
//  Created by Joshua Escribano on 8/6/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

class SessionManager {
    static var allSessionsPath = pathWithName("sessions.dat")
    
    class func pathWithName(_ name: String) -> String? {
        var url = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        url = url?.appendingPathComponent(name)
        return url?.path
    }
    
    class func saveSession(_ session: Session?, sessions inSessions: [Session]? = nil) {
        var sessions = inSessions
        if session != nil && allSessionsPath != nil {
            if inSessions == nil {
                sessions = loadSessions()
            }
            if sessions?.first?.name != session?.name {
                sessions?.insert(session!, at: 0)
            }
            NSKeyedArchiver.archiveRootObject(sessions!, toFile: allSessionsPath!)
        }
    }
    
    class func saveSessions(_ inSessions: [Session]? = nil) {
        var sessions = inSessions
        if inSessions == nil {
            sessions = Globals.sessions
        }
        NSKeyedArchiver.archiveRootObject(sessions!, toFile: allSessionsPath!)
    }
    
    class func loadSession(_ key: String) -> Session {
        var sessions: [Session]?
        if allSessionsPath != nil {
            sessions = NSKeyedUnarchiver.unarchiveObject(withFile: allSessionsPath!) as? [Session]
        }
        let session = sessions?.first(where: { (session: Session) in
            session.name == key
        })
        return session ?? Session(name: "Blank Session")
    }
    
    class func loadSessions() -> [Session] {
        var sessions: [Session]?
        if allSessionsPath != nil {
            sessions = NSKeyedUnarchiver.unarchiveObject(withFile: "sessions") as? [Session]
        }
        if sessions == nil {
            let newSession = Session(name: "New Session")
            sessions = [Session]()
            sessions?.append(newSession)
            saveSessions(sessions)
        }
        return sessions!
    }
}
