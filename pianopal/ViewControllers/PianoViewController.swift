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

class PianoViewController : UIViewController, AKPickerViewDataSource, AKPickerViewDelegate, PianoNavigationProtocol {
    
    let pianoView = PianoView(frame: Dimensions.pianoRect)
    let playButton = UIButton(frame: Dimensions.rightBarButtonRect)
    var scalesPickerView: AKPickerView?
    var chordsPickerView: AKPickerView?
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
        let pianoNavigationController = navigationController as? PianoNavigationViewController
        let navigationItem = pianoNavigationController?.customNavigationItem
        navigationItem?.titleView = nil
        switch pianoViewMode {
        case .scale:
            navigationItem?.title = "Scales"
            if !scales.isEmpty {
                scalesPickerView = AKPickerView(frame: Dimensions.titleScrollViewRect)
                scalesPickerView?.dataSource = self
                scalesPickerView?.delegate = self
                DispatchQueue.main.async {
                    navigationItem?.titleView = self.scalesPickerView!
                }
                scalesPickerView?.selectItem((scalesPickerView?.selectedItem)!)
                let scale = scales[(scalesPickerView?.selectedItem)!]
                PianoViewHightlighter.highlightScale(scale, pianoView: pianoView)
            }
        case .chord:
            navigationItem?.title = "Chords"
            if !chords.isEmpty {
                chordsPickerView = AKPickerView(frame: Dimensions.titleScrollViewRect)
                chordsPickerView?.dataSource = self
                chordsPickerView?.delegate = self
                DispatchQueue.main.async {
                    navigationItem?.titleView = self.chordsPickerView!
                }
                chordsPickerView?.selectItem((chordsPickerView?.selectedItem)!)
                let chord = chords[(chordsPickerView?.selectedItem)!]
                PianoViewHightlighter.highlightChord(chord, pianoView: pianoView)
            }
        case .identify:
            navigationItem?.title = "Identify"
            // TODO set up listeners
        }
        PianoViewHightlighter.labelNotes(pianoView)
    }
    
    func updateNavigationItem() {
        // TODO
        let pianoNavigationController = navigationController as? PianoNavigationViewController
        let menuButton = pianoNavigationController?.menuButton
        pianoNavigationController?.customNavigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton!)
        pianoNavigationController?.customNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: playButton)
        
    }
    
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        switch pianoViewMode {
        case .chord:
            return chords.count
        case .scale:
            return scales.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
        switch pianoViewMode {
        case .chord:
            return chords[item].simpleDescription()
        case .scale:
            return scales[item].simpleDescription()
        default:
            return ""
        }
    }

    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        highlight(pianoViewMode)
    }
    
    func highlight(_ pianoViewMode: PianoViewMode) {
        switch pianoViewMode {
        case .chord:
            let chord = chords[(chordsPickerView?.selectedItem)!]
            PianoViewHightlighter.highlightChord(chord, pianoView: pianoView)
        case .scale:
            let scale = scales[(scalesPickerView?.selectedItem)!]
            PianoViewHightlighter.highlightScale(scale, pianoView: pianoView)
        default:
            break
        }
    }
    
}
