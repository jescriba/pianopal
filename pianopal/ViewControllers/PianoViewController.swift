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
    
    let pianoView = PianoView(frame: Dimensions.pianoRect)
    let playButton = UIButton(frame: Dimensions.rightBarButtonRect)
    var chords = [Chord]()
    var scales = [Scale]()
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
    
    override func viewDidLoad() {
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(pianoView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.white
        
        updateNavigationItem()
        setupViewMode(pianoViewMode)
    }
    
    func setupViewMode(_ pianoViewMode: PianoViewMode) {
        // TODO set up the UI and stuff for this view mode
        let pianoNavigationController = navigationController as? PianoNavigationViewController
        let navigationItem = pianoNavigationController?.customNavigationItem
        navigationItem?.titleView = nil
        switch pianoViewMode {
        case .scale:
            navigationItem?.title = "Scales"
        case .chord:
            navigationItem?.title = "Chords"
        case .identify:
            navigationItem?.title = "Identify"
        }
    }
    
    func updateNavigationItem() {
        // TODO
        let pianoNavigationController = navigationController as? PianoNavigationViewController
        let menuButton = pianoNavigationController?.menuButton
        pianoNavigationController?.customNavigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton!)
        pianoNavigationController?.customNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: playButton)
        
    }
    
}
