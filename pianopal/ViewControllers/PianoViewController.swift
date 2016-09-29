//
//  PianoViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 9/29/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

enum PianoViewMode {
    case scale, chord, identify
}

class PianoViewController : UIViewController, PianoNavigationProtocol {
    
    let pianoView = PianoView()
    let playButton = UIButton(frame: Dimensions.rightBarButtonRect)
    private var _pianoViewMode = PianoViewMode.scale
    var pianoViewMode: PianoViewMode {
        get {
            return _pianoViewMode
        } set {
            _pianoViewMode = newValue
            setupViewMode(pianoViewMode)
        }
    }
    var highlightedNoteButtons: [NoteButton] {
        get {
            // TODO
            return [NoteButton]()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupViewMode(pianoViewMode)
    }
    
    func setupViewMode(_ pianoViewMode: PianoViewMode) {
        // TODO set up the UI and stuff for this view mode
    }
    
    func updateNavigationItem() {
        // TODO
    }
    
}
