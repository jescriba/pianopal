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
    
    func highlightChord(chord: Chord?) {
        if (chord == nil) {
            return
        }
        highlightedChord = chord
        clearHighlighting()
        for noteButton in pianoView.noteButtons {
            labelForPreferences(noteButton)
            if chord!.notes.contains(noteButton.note!) {
                pianoView.highlightedNoteButtons.append(noteButton)
                dispatch_async(dispatch_get_main_queue(), {
                    noteButton.illuminate()
                })
            }
        }
    }
    
    func clearHighlighting() {
        for noteButton in pianoView.highlightedNoteButtons {
            dispatch_async(dispatch_get_main_queue(), {
                noteButton.deIlluminate()
            })
        }
        pianoView.highlightedNoteButtons.removeAll()
    }
    
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
        return chords.count
    }
    
    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
        return chords[item].simpleDescription()
    }
    
    func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
        highlightChord(chords[item])
    }
    
    func labelNotes() {
        for noteButton in pianoView.noteButtons {
            labelForPreferences(noteButton)
        }
    }
    
    func labelForPreferences(noteButton: NoteButton) {
        var title = ""
        if Preferences.labelNoteLetter {
            title = (noteButton.note?.simpleDescription())!
        }
//        if Preferences.labelNoteNumber {
//            let index = highlightedChord?.indexOf(noteButton.note!)
//            if (highlightedChord != nil && index != nil) {
//                title += String(index! + 1)
//            }
//        }
        noteButton.label(title)
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        labelNotes()
    }
}
