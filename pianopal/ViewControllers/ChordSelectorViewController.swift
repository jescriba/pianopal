//
//  ChordSelectorViewController.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/13/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class ChordSelectorViewController : UIViewController {
    @IBOutlet weak var rootNotePickerView: UIPickerView!
    @IBOutlet weak var chordTypePickerView: UIPickerView!
    @IBOutlet weak var chordNameLabel: UILabel!
    @IBOutlet weak var generateChordsButton: UIButton!
    @IBOutlet weak var rootNoteLabel: UILabel!
    @IBOutlet weak var chordTypeLabel: UILabel!
    
    var rootNotePickerViewDelegate: RootNotePickerViewDelegate?
    let rootNotePickerViewDataSource = RootNotePickerViewDataSource()
    var chordTypePickerViewDelegate: ChordTypePickerViewDelegate?
    let chordTypePickerViewDataSource = ChordTypePickerViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = Colors.pickerBackground
        rootNotePickerViewDelegate = RootNotePickerViewDelegate(nameLabel: chordNameLabel)
        chordTypePickerViewDelegate = ChordTypePickerViewDelegate(chordNameLabel: chordNameLabel)
        chordNameLabel.text = "C Major"
        chordNameLabel.font = Fonts.toolbarAction
        generateChordsButton.titleLabel!.font = Fonts.generateButton
        chordTypeLabel.font = Fonts.pickerSectionDescription
        rootNoteLabel.font = Fonts.pickerSectionDescription
        rootNotePickerView.delegate = rootNotePickerViewDelegate
        rootNotePickerView.dataSource = rootNotePickerViewDataSource
        chordTypePickerView.delegate = chordTypePickerViewDelegate
        chordTypePickerView.dataSource = chordTypePickerViewDataSource
        generateChordsButton.addTarget(self, action: #selector(generateChords), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func generateChords() {
        let rootNote = rootNotePickerView.selectedRowInComponent(0)
        let chordType = chordTypePickerView.selectedRowInComponent(0)
        let chord = ChordGenerator.generateChord(Note(rawValue: rootNote)!, chordType: ChordType(rawValue: chordType)!)
        UIApplication.sharedApplication().delegate?.window?!.rootViewController = PianoViewController(chord: chord)
    }
}