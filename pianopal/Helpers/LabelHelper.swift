//
//  LabelHelper.swift
//  pianopal
//
//  Created by Joshua Escribano on 8/3/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation

class LabelHelper {
    static func intervalNumberAsString(_ note: Note, rootNote: Note) -> String {
        var interval = note.rawValue - rootNote.rawValue
        if interval < 0 {
            interval = interval + 12
        }
        switch interval {
        case 0:
            return "1"
        case 1:
            return "1#"
        case 2:
            return "2"
        case 3:
            return "3b"
        case 4:
            return "3"
        case 5:
            return "4"
        case 6:
            return "5b"
        case 7:
            return "5"
        case 8:
            return "5#"
        case 9:
            return "6"
        case 10:
            return "7b"
        case 11:
            return "7"
        default:
            return ""
        }
    }
}
