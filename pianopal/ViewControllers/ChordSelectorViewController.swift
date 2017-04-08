//
//  ChordSelectorViewController.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/13/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class ChordSelectorViewController : UIViewController, PianoNavigationProtocol {
    
    @IBOutlet weak var keyNotePickerView: KeyNotePickerView!
    @IBOutlet weak var keyTypePickerView: KeyTypePickerView!
    @IBOutlet weak var rootNotePickerView: RootNotePickerView!
    @IBOutlet weak var chordTypePickerView: ChordTypePickerView!
    
    let cancelChordButton = UIButton(frame: Dimensions.menuButtonRect)
    let saveChordButton = UIButton(frame: Dimensions.rightBarButtonRect)
    var pianoNavigationViewController: PianoNavigationViewController?
    var chord = ChordGenerator.generateChord(.c, chordType: .Major)
    var key: Key!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.interactivePopGestureRecognizer?.isEnabled = false
        pianoNavigationViewController = navigationController as? PianoNavigationViewController
        
        view.backgroundColor = Colors.pickerBackground
        keyNotePickerView.keyDelegate = self
        keyTypePickerView.keyDelegate = self
        rootNotePickerView.chordDelegate = self
        chordTypePickerView.chordDelegate = self
        key = Key()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateNavigationItem()
    }
    
    func updateNavigationItem() {
        pianoNavigationViewController?.customNavigationItem.title = "Select Chord"
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = nil
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = nil
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveChordButton)
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelChordButton)
    }
}

extension ChordSelectorViewController: KeyDelegate {
    
    func keyChanged(note: Note?, type: KeyType?) {
        if note != nil {
            key.rootNote = note!
        }
        
        if type != nil {
            key.keyType = type!
        }
        
        if note == nil && type == nil {
            key.rootNote = nil
            key.keyType = KeyType.unset
        }
        
        // Use all ordered notes/chordtypes unless key is set
        var notes = Constants.orderedNotes
        var chordTypes = Constants.orderedChordTypes
        
        if key.isSet {
            // Update UI to filter
            notes = key.notes
            chordTypes = [key.chordTypes.first!]
        }
        rootNotePickerView.notes = notes
        chordTypePickerView.chordTypes = chordTypes
        rootNotePickerView.reloadAllComponents()
        chordTypePickerView.reloadAllComponents()
    }
}

extension ChordSelectorViewController: ChordDelegate {
    
    func chordChanged(note: Note?, type: ChordType?) {
        let newNote = note ?? chord.notes.first
        var newType = type ?? chord.chordType
        if note != nil && type == nil {
            // Update chord type in picker
            let newTypes = key.chordTypesFor(note: note!)
            newType = newTypes.first!
            //TODO: Consider expanding chord compatibilities
            chordTypePickerView.chordTypes = newTypes
            chordTypePickerView.reloadAllComponents()
        }
        chord = ChordGenerator.generateChord(newNote!, chordType: newType!)
    }
    
}
