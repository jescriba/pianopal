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
    
    let cancelChordButton = UIButton(frame: Dimensions.menuButtonRect)
    let saveChordButton = UIButton(frame: Dimensions.rightBarButtonRect)
    let rootNotePickerViewDataSource = RootNotePickerViewDataSource()
    let chordTypePickerViewDataSource = ChordTypePickerViewDataSource()
    var rootNotePickerViewDelegate: RootNotePickerViewDelegate?
    var chordTypePickerViewDelegate: ChordTypePickerViewDelegate?
    var pianoNavigationViewController: PianoNavigationViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.interactivePopGestureRecognizer?.isEnabled = false
        pianoNavigationViewController = navigationController as? PianoNavigationViewController
        
        view.backgroundColor = Colors.pickerBackground
        let navigationItem = pianoNavigationViewController?.customNavigationItem
        rootNotePickerViewDelegate = RootNotePickerViewDelegate(navigationItem: navigationItem!)
        chordTypePickerViewDelegate = ChordTypePickerViewDelegate(navigationItem: navigationItem!)
        chordTypeLabel.font = Fonts.pickerTitle
        rootNoteLabel.font = Fonts.pickerTitle
        rootNotePickerView.delegate = rootNotePickerViewDelegate
        rootNotePickerView.dataSource = rootNotePickerViewDataSource
        chordTypePickerView.delegate = chordTypePickerViewDelegate
        chordTypePickerView.dataSource = chordTypePickerViewDataSource
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
