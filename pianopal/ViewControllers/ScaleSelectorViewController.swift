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
    
    @IBOutlet weak var rootNoteLabel: UILabel!
    @IBOutlet weak var scaleTypeLabel: UILabel!
    @IBOutlet weak var scaleTypePickerView: UIPickerView!
    @IBOutlet weak var rootNotePickerView: UIPickerView!
    @IBOutlet weak var modePickerView: UIPickerView!
    
    let cancelScaleButton = UIButton(frame: Dimensions.menuButtonRect)
    let saveScaleButton = UIButton(frame: Dimensions.rightBarButtonRect)
    let rootNotePickerViewDataSource = RootNotePickerViewDataSource()
    let scaleTypePickerViewDataSource = ScaleTypePickerViewDataSource()
    var rootNotePickerViewDelegate: RootNotePickerViewDelegate?
    var scaleTypePickerViewDelegate: ScaleTypePickerViewDelegate?
    var pianoNavigationViewController: PianoNavigationViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.pickerBackground
        navigationController!.interactivePopGestureRecognizer?.isEnabled = false
        let navigationItem = pianoNavigationViewController?.customNavigationItem
        rootNotePickerViewDelegate = RootNotePickerViewDelegate(navigationItem: navigationItem!)
        scaleTypePickerViewDelegate = ScaleTypePickerViewDelegate(navigationItem: navigationItem!)
        rootNotePickerView.delegate = rootNotePickerViewDelegate
        rootNotePickerView.dataSource = rootNotePickerViewDataSource
        scaleTypePickerView.delegate = scaleTypePickerViewDelegate
        scaleTypePickerView.dataSource = scaleTypePickerViewDataSource
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
        //TODO
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
