//
//  ScaleSelectorViewController.swift
//  pianotools
//
//  Created by joshua on 6/15/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class ScaleSelectorViewController : UIViewController, PianoNavigationProtocol {
    
    @IBOutlet weak var scaleTypePickerView: ScaleTypePickerView!
    @IBOutlet weak var rootNotePickerView: RootNotePickerView!
    @IBOutlet weak var modePickerView: UIPickerView!
    
    let cancelScaleButton = UIButton(frame: Dimensions.menuButtonRect)
    let saveScaleButton = UIButton(frame: Dimensions.rightBarButtonRect)
    var pianoNavigationViewController: PianoNavigationViewController?
    var scale: Scale!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.pickerBackground
        navigationController!.interactivePopGestureRecognizer?.isEnabled = false
        scale = ScaleGenerator.generateScale(.c, scaleType: .Major)
        scaleTypePickerView.scaleDelegate = self
        rootNotePickerView.scaleDelegate = self
        modePickerView.delegate = self
        modePickerView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateNavigationItem()
    }
    
    func updateNavigationItem() {
        pianoNavigationViewController = navigationController as? PianoNavigationViewController
        pianoNavigationViewController?.customNavigationItem.title = "Select Scale"
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = nil
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = nil
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveScaleButton)
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelScaleButton)
    }
}

// MARK: UIPickerViewDelegate/DataSource for Modes
extension ScaleSelectorViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Mode(rawValue: row)?.simpleDescription()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        scale.mode = Mode(rawValue: row) ?? .ionian
    }
    
}

extension ScaleSelectorViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.totalModes
    }
    
}

extension ScaleSelectorViewController: ScaleDelegate {
    func scaleChanged(note: Note?, type: ScaleType?) {
        let newNote = note ?? scale.rootNote
        let newType = type ?? scale.scaleType
        scale = ScaleGenerator.generateScale(newNote!, scaleType: newType!)
        pianoNavigationViewController?.customNavigationItem.title = scale.simpleDescription()
    }
}
