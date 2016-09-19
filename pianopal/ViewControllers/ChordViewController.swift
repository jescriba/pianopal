//
//  ChordViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/23/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class ChordViewController: UIViewController, AKPickerViewDataSource, AKPickerViewDelegate, PianoNavigationProtocol {
    let pianoView = PianoView(frame: Dimensions.pianoRect)
    var pianoNavigationViewController: PianoNavigationViewController?
    var menuBarButton: UIBarButtonItem?
    var changeModeBarButton: UIBarButtonItem?
    var playBarButton: UIBarButtonItem?
    var chords = [Chord]()
    var chordsPickerView: AKPickerView?
    var highlightedChord: Chord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        updateNavigationItem()
        labelNotes()
        view.addSubview(pianoView)
    }
    
    func updateNavigationItem() {
        pianoNavigationViewController = (navigationController as! PianoNavigationViewController)
        pianoNavigationViewController?.customNavigationItem.titleView = nil
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = nil
        menuBarButton = UIBarButtonItem(customView: pianoNavigationViewController!.menuButton)
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = menuBarButton
        playBarButton = UIBarButtonItem(customView: pianoNavigationViewController!.playButton)
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = playBarButton
        if chords.isEmpty {
            pianoNavigationViewController!.customNavigationItem.title = "Piano Chords"
        } else {
            setUpChordScrollView()
        }
    }
    
    func setUpChordScrollView() {
        chordsPickerView = AKPickerView(frame: Dimensions.titleScrollViewRect)
        chordsPickerView?.dataSource = self
        chordsPickerView?.delegate = self
        pianoNavigationViewController!.customNavigationItem.titleView = chordsPickerView!
    }
    
    func highlightChord(_ chord: Chord?) {
        if (chord == nil) {
            return
        }
        highlightedChord = chord
        clearHighlighting()
        for noteButton in pianoView.noteButtons {
            labelForPreferences(noteButton)
            if chord!.notes.contains(noteButton.note!) {
                pianoView.highlightedNoteButtons.append(noteButton)
                DispatchQueue.main.async(execute: {
                    noteButton.illuminate([KeyColorPair(whiteKeyColor: Colors.highlightedWhiteKeyColor, blackKeyColor: Colors.highlightedBlackKeyColor)])
                })
            }
        }
    }
    
    func clearHighlighting() {
        for noteButton in pianoView.highlightedNoteButtons {
            DispatchQueue.main.async(execute: {
                noteButton.deIlluminate()
            })
        }
        pianoView.highlightedNoteButtons.removeAll()
    }
    
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        return chords.count
    }
    
    func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
        return chords[item].simpleDescription()
    }
    
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        highlightChord(chords[item])
        labelNotes()
    }
    
    func labelNotes() {
        for noteButton in pianoView.noteButtons {
            labelForPreferences(noteButton)
        }
    }
    
    func removeLabelNotes() {
        for noteButton in pianoView.noteButtons {
            noteButton.label("")
        }
    }
    
    func labelForPreferences(_ noteButton: NoteButton) {
        var title = ""
        if Preferences.labelNoteLetter {
            title = (noteButton.note?.simpleDescription())!
        }
        if Preferences.labelNoteNumber {
            let index = highlightedChord?.indexOf(noteButton.note!)
            if (highlightedChord != nil && index != nil) {
                title += LabelHelper.intervalNumberAsString(noteButton.note!, rootNote: highlightedChord!.notes[0])
            }
        }
        noteButton.label(title)
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        clearHighlighting()
        removeLabelNotes()
    }
}
