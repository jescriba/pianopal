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
    var rootNotePickerViewDelegate: RootNotePickerViewDelegate?
    let rootNotePickerViewDataSource = RootNotePickerViewDataSource()
    var scaleTypePickerViewDelegate: ScaleTypePickerViewDelegate?
    let scaleTypePickerViewDataSource = ScaleTypePickerViewDataSource()
    var pianoNavigationViewController: PianoNavigationViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.pickerBackground

//        navigationController!.interactivePopGestureRecognizer?.isEnabled = false
//        updateNavigationItem()
//        let navigationItem = pianoNavigationViewController?.customNavigationItem
//        rootNotePickerViewDelegate = RootNotePickerViewDelegate(navigationItem: navigationItem!)
//        scaleTypePickerViewDelegate = ScaleTypePickerViewDelegate(navigationItem: navigationItem!)
//        scaleTypeLabel.font = Fonts.pickerSectionDescription
//        rootNoteLabel.font = Fonts.pickerSectionDescription
//        rootNotePickerView.delegate = rootNotePickerViewDelegate
//        rootNotePickerView.dataSource = rootNotePickerViewDataSource
//        scaleTypePickerView.delegate = scaleTypePickerViewDelegate
//        scaleTypePickerView.dataSource = scaleTypePickerViewDataSource
    }
    
    func updateNavigationItem() {
//        pianoNavigationViewController = navigationController as? PianoNavigationViewController
//        pianoNavigationViewController?.customNavigationItem.title = "Select Scale"
//        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = nil
//        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = nil
//        let saveScaleButton = pianoNavigationViewController?.saveScaleButton
//        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveScaleButton!)
//        let cancelScaleButton = pianoNavigationViewController?.cancelScaleButton
//        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelScaleButton!)
    }
}
