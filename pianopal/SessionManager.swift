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
        let t = NSKeyedArchiver.archiveRootObject(sessions!, toFile: allSessionsPath!)
    }
    
    class func loadSession(_ name: String) {
        var sessions = Globals.sessions
        if sessions.isEmpty {
            sessions = loadSessions()
        }
        if allSessionsPath != nil {
            let session = sessions.first(where: { (session: Session) in
                session.name == name
            })
            if let sesh = session {
                bringSessionToTop(sesh)
            }
        }
    }
    
    class func loadSessions() -> [Session] {
        var sessions: [Session]?
        if allSessionsPath != nil {
            sessions = NSKeyedUnarchiver.unarchiveObject(withFile: "sessions") as? [Session]
        }
        if sessions == nil {
            let dateString = SessionManager.uniqueSessionDateName()
            let newSession = Session(name: dateString)
            sessions = [Session]()
            sessions?.append(newSession)
            saveSessions(sessions)
        }
        return sessions!
    }
    
    class func uniqueSessionDateName() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .medium
        let dateString = "\(dateFormatter.string(from: currentDate)) \(arc4random() % 1000)"
        var isUnique = true
        for session in Globals.sessions {
            if session.name == dateString {
                isUnique = false
            }
        }
        // Just going to assume people aren't making 1000+
        // sessions a day
        if !isUnique {
            return uniqueSessionDateName()
        }
        return dateString
    }
    
    class func uniqueSessionName(_ str: String) -> String {
        for session in Globals.sessions {
            if session.name == str {
                return uniqueSessionName("\(str) \(arc4random() % 1000)")
            }
        }
        return str
    }
    
    private class func bringSessionToTop(_ session: Session) {
        let index = Globals.sessions.index(of: session)
        if let i = index {
            Globals.sessions.remove(at: i)
            Globals.sessions.insert(session, at: 0)
        }
    }
}
