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
    
    // Used just for debugging locally
    class func deleteSessions(){
        try? _ = FileManager.default.removeItem(atPath: allSessionsPath!)
    }
    
    class func saveSessions(_ inSessions: [Session]? = nil) {
        var sessions = inSessions
        if inSessions == nil {
            sessions = Globals.sessions
        }
        NSKeyedArchiver.archiveRootObject(sessions!, toFile: allSessionsPath!)
    }
    
    class func newSession() -> Session {
        return Session(name: sessionDateName())
    }
    
    class func loadSession(_ session: Session?) {
        guard let session = session else { return }
        
        var sessions = Globals.sessions
        if sessions.isEmpty {
            sessions = loadSessions()
        }
        if allSessionsPath != nil {
            let session = sessions.first(where: { (sessionToCheck: Session) in
                sessionToCheck.uid == session.uid
            })
            if let sesh = session {
                bringSessionToTop(sesh)
            }
        }
    }
    
    class func loadSessions() -> [Session] {
        var sessions: [Session]?
        if let path = allSessionsPath {
            sessions = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [Session]
        }
        if sessions == nil || sessions!.isEmpty {
            let dateString = SessionManager.sessionDateName()
            let newSession = Session(name: dateString)
            sessions = [Session]()
            sessions?.append(newSession)
            saveSessions(sessions)
        }
        return sessions!
    }
    
    class func sessionDateName() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: currentDate)
        var dateMatchCount = 0
        let regex = try! NSRegularExpression(pattern: "^\(dateString) - \\d+$", options: .anchorsMatchLines)
        for session in Globals.sessions {
            if (regex.numberOfMatches(in: session.name, options: .anchored, range: NSMakeRange(0, session.name.characters.count)) > 0) || session.name == dateString {
                dateMatchCount += 1
            }
        }
        
        if (dateMatchCount > 0) {
            return "\(dateString) - \(dateMatchCount)"
        }
        
        return dateString
    }

    private class func bringSessionToTop(_ session: Session) {
        let index = Globals.sessions.index(of: session)
        if let i = index {
            Globals.sessions.remove(at: i)
            Globals.sessions.insert(session, at: 0)
        }
    }
}
