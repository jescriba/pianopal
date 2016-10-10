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
    var notesToIdentify = [Note]()
    var scalesPickerView: AKPickerView?
    var chordsPickerView: AKPickerView?
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
            return pianoView.highlightedNoteButtons
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        PianoViewHightlighter.clearHighlighting(pianoView: pianoView)
        pianoView.removeTargets()
        notesToIdentify.removeAll()
        switch pianoViewMode {
        case .scale:
            navigationItem?.title = "Scales"
            if !Globals.scales.isEmpty {
                scalesPickerView = AKPickerView(frame: Dimensions.titleScrollViewRect)
                scalesPickerView?.dataSource = self
                scalesPickerView?.delegate = self
                DispatchQueue.main.async {
                    navigationItem?.titleView = self.scalesPickerView!
                }
                scalesPickerView?.selectItem((scalesPickerView?.selectedItem)!)
                let scale = Globals.scales[(scalesPickerView?.selectedItem)!]
                PianoViewHightlighter.highlightScale(scale, pianoView: pianoView)
            }
        case .chord:
            navigationItem?.title = "Chords"
            if !Globals.chords.isEmpty {
                chordsPickerView = AKPickerView(frame: Dimensions.titleScrollViewRect)
                chordsPickerView?.dataSource = self
                chordsPickerView?.delegate = self
                DispatchQueue.main.async {
                    navigationItem?.titleView = self.chordsPickerView!
                }
                chordsPickerView?.selectItem((chordsPickerView?.selectedItem)!)
                let chord = Globals.chords[(chordsPickerView?.selectedItem)!]
                PianoViewHightlighter.highlightChord(chord, pianoView: pianoView)
            }
        case .identify:
            navigationItem?.title = "Identify"
            pianoView.addTarget(self, action: #selector(noteSelectedForIdentification), for: .touchUpInside)
        }
    }
    
        func noteSelectedForIdentification(_ sender: NoteButton) {
            if sender.illuminated {
                sender.deIlluminate()
                pianoView.highlightedNoteButtons.remove(at: pianoView.highlightedNoteButtons.index(of: sender)!)
                notesToIdentify.remove(at: notesToIdentify.index(of: sender.note!)!)
            } else {
                sender.illuminate([KeyColorPair(whiteKeyColor: Colors.highlightedWhiteKey, blackKeyColor: Colors.highlightedBlackKey)])
                pianoView.highlightedNoteButtons.append(sender)
                notesToIdentify.append(sender.note!)
            }
            DispatchQueue.global().async(execute: {
                let identifiedChord = ChordIdentifier.chordForNotes(self.notesToIdentify)
                var chordDescription: String?
                if identifiedChord == nil {
                    chordDescription = "N/A"
                } else {
                    chordDescription = identifiedChord?.simpleDescription()
                }
                DispatchQueue.main.async(execute: {
                    let navController = self.navigationController as! PianoNavigationViewController
                    navController.customNavigationItem.title = chordDescription
                })
            })
        }
    
    func updateNavigationItem() {
        let pianoNavigationController = navigationController as? PianoNavigationViewController
        pianoNavigationController?.customNavigationItem.rightBarButtonItem = nil
        let menuButton = pianoNavigationController?.menuButton
        pianoNavigationController?.customNavigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton!)
        pianoNavigationController?.customNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: playButton)
        
    }
    
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        switch pianoViewMode {
        case .chord:
            return Globals.chords.count
        case .scale:
            return Globals.scales.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
        switch pianoViewMode {
        case .chord:
            return Globals.chords[item].simpleDescription()
        case .scale:
            return Globals.scales[item].simpleDescription()
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
            let chord = Globals.chords[(chordsPickerView?.selectedItem)!]
            PianoViewHightlighter.highlightChord(chord, pianoView: pianoView)
        case .scale:
            let scale = Globals.scales[(scalesPickerView?.selectedItem)!]
            PianoViewHightlighter.highlightScale(scale, pianoView: pianoView)
        default:
            break
        }
    }
    
}
