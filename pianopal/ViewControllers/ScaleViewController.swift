//
//  ScaleViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/23/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class ScaleViewController: UIViewController, AKPickerViewDataSource, AKPickerViewDelegate,PianoNavigationProtocol {
    let pianoView = PianoView(frame: Dimensions.pianoRect)
    var pianoNavigationViewController: PianoNavigationViewController?
    var menuBarButton: UIBarButtonItem?
    var changeModeBarButton: UIBarButtonItem?
    var scales = [Scale]()
    var scalesPickerView: AKPickerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        automaticallyAdjustsScrollViewInsets = false
        updateNavigationItem()
        view.addSubview(pianoView)
    }
    
    func updateNavigationItem() {
        pianoNavigationViewController = (navigationController as! PianoNavigationViewController)
        pianoNavigationViewController?.customNavigationItem.titleView = nil
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = nil
        menuBarButton = UIBarButtonItem(customView: pianoNavigationViewController!.menuButton)
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = menuBarButton
        if scales.isEmpty {
            pianoNavigationViewController!.customNavigationItem.title = "Piano Scales"
        } else {
            setUpScaleScrollView()
        }
    }
    
    func setUpScaleScrollView() {
        scalesPickerView = AKPickerView(frame: Dimensions.titleScrollViewRect)
        scalesPickerView?.dataSource = self
        scalesPickerView?.delegate = self
        pianoNavigationViewController!.customNavigationItem.titleView = scalesPickerView!
    }

    func highlightScale(scale: Scale?) {
        if (scale == nil) {
            return
        }
        clearHighlighting()
        for noteButton in pianoView.noteButtons {
            if scale!.notes.contains(noteButton.note!) {
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
        return scales.count
    }
    
    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
        return scales[item].simpleDescription()
    }
    
    func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
        highlightScale(scales[item])
    }

}
