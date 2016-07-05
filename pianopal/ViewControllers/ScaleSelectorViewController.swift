//
//  ScaleSelectorViewController.swift
//  pianotools
//
//  Created by joshua on 6/15/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class ScaleSelectorViewController : UIViewController {
    @IBOutlet weak var scaleNameLabel: UILabel!
    @IBOutlet weak var generateScalesButton: UIButton!
    @IBOutlet weak var rootNoteLabel: UILabel!
    @IBOutlet weak var scaleTypeLabel: UILabel!
    @IBOutlet weak var scaleTypePickerView: UIPickerView!
    @IBOutlet weak var rootNotePickerView: UIPickerView!
    var rootNotePickerViewDelegate: RootNotePickerViewDelegate?
    let rootNotePickerViewDataSource = RootNotePickerViewDataSource()
    var scaleTypePickerViewDelegate: ScaleTypePickerViewDelegate?
    let scaleTypePickerViewDataSource = ScaleTypePickerViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.pickerBackground

        rootNotePickerViewDelegate = RootNotePickerViewDelegate(nameLabel: scaleNameLabel)
        scaleTypePickerViewDelegate = ScaleTypePickerViewDelegate(scaleNameLabel: scaleNameLabel)
        scaleNameLabel.text = "C Major"
        scaleNameLabel.font = Fonts.toolbarAction
        generateScalesButton.titleLabel!.font = Fonts.generateButton
        scaleTypeLabel.font = Fonts.pickerSectionDescription
        rootNoteLabel.font = Fonts.pickerSectionDescription
        rootNotePickerView.delegate = rootNotePickerViewDelegate
        rootNotePickerView.dataSource = rootNotePickerViewDataSource
        scaleTypePickerView.delegate = scaleTypePickerViewDelegate
        scaleTypePickerView.dataSource = scaleTypePickerViewDataSource
        generateScalesButton.addTarget(self, action: #selector(generateScales), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func generateScales() {
        let rootNote = rootNotePickerView.selectedRowInComponent(0)
        let scaleType = scaleTypePickerView.selectedRowInComponent(0)
        let scale = ScaleGenerator.generateScale(Note(rawValue: rootNote)!, scaleType: ScaleType(rawValue: scaleType)!)
        UIApplication.sharedApplication().delegate?.window?!.rootViewController = PianoViewController(scale: scale)
    }
}