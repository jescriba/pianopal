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
    @IBOutlet weak var rootNotePickerView: UIPickerView!
    @IBOutlet weak var chordTypePickerView: UIPickerView!
    @IBOutlet weak var rootNoteLabel: UILabel!
    @IBOutlet weak var chordTypeLabel: UILabel!
    
    var rootNotePickerViewDelegate: RootNotePickerViewDelegate?
    let rootNotePickerViewDataSource = RootNotePickerViewDataSource()
    var chordTypePickerViewDelegate: ChordTypePickerViewDelegate?
    let chordTypePickerViewDataSource = ChordTypePickerViewDataSource()
    var pianoNavigationViewController: PianoNavigationViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.interactivePopGestureRecognizer?.enabled = false
        pianoNavigationViewController = navigationController as? PianoNavigationViewController
        updateNavigationItem()
        
        view.backgroundColor = Colors.pickerBackground
        let navigationItem = pianoNavigationViewController?.customNavigationItem
        rootNotePickerViewDelegate = RootNotePickerViewDelegate(navigationItem: navigationItem!)
        chordTypePickerViewDelegate = ChordTypePickerViewDelegate(navigationItem: navigationItem!)
        chordTypeLabel.font = Fonts.pickerSectionDescription
        rootNoteLabel.font = Fonts.pickerSectionDescription
        rootNotePickerView.delegate = rootNotePickerViewDelegate
        rootNotePickerView.dataSource = rootNotePickerViewDataSource
        chordTypePickerView.delegate = chordTypePickerViewDelegate
        chordTypePickerView.dataSource = chordTypePickerViewDataSource
    }
    
    func updateNavigationItem() {
        pianoNavigationViewController?.customNavigationItem.title = "Select Chord"
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = nil
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = nil
        let saveChordButton = pianoNavigationViewController?.saveChordButton
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveChordButton!)
        let cancelChordButton = pianoNavigationViewController?.cancelChordButton
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelChordButton!)
    }

}