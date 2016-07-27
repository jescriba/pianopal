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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        updateNavigationItem()
        view.addSubview(pianoView)
    }
    
    func updateNavigationItem() {
        pianoNavigationViewController = (navigationController as! PianoNavigationViewController)
        pianoNavigationViewController?.customNavigationItem.titleView = nil
        menuBarButton = UIBarButtonItem(customView: pianoNavigationViewController!.menuButton)
        changeModeBarButton = UIBarButtonItem(customView: pianoNavigationViewController!.changeModeButton)
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = menuBarButton
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = changeModeBarButton
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
        clearHighlighting()
        for noteButton in pianoView.noteButtons {
            if chord!.notes.contains(noteButton.note!) {
                pianoView.highlightedNoteButtons.append(noteButton)
                dispatch_async(dispatch_get_main_queue(), {
                    noteButton.backgroundColor = Colors.chordColor
                })
            }
        }
    }
    
    func clearHighlighting() {
        for noteButton in pianoView.highlightedNoteButtons {
            dispatch_async(dispatch_get_main_queue(), {
                noteButton.backgroundColor = noteButton.determineNoteColor(noteButton.note!)
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
}
