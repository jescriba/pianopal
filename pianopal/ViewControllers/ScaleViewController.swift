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
    var playBarButton: UIBarButtonItem?
    var scales = [Scale]()
    var scalesPickerView: AKPickerView?
    var highlightedScale: Scale?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.interactivePopGestureRecognizer?.isEnabled = false
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
        playBarButton = UIBarButtonItem(customView: pianoNavigationViewController!.playButton)
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = playBarButton
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

    func highlightScale(_ scale: Scale?) {
        if (scale == nil) {
            return
        }
        highlightedScale = scale
        clearHighlighting()
        for noteButton in pianoView.noteButtons {
            labelForPreferences(noteButton)
            if scale!.notes.contains(noteButton.note!) {
                pianoView.highlightedNoteButtons.append(noteButton)
                let colors = colorForPreferences(noteButton)
                DispatchQueue.main.async(execute: {
                    noteButton.illuminate(colors)
                })
            }
        }
    }
    
    func clearHighlighting() {
        for noteButton in pianoView.highlightedNoteButtons {
            DispatchQueue.main.async(execute: {
                noteButton.deIlluminate()
            })
        }
        pianoView.highlightedNoteButtons.removeAll()
    }
    
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        return scales.count
    }
    
    func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
        return scales[item].simpleDescription()
    }
    
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        highlightScale(scales[item])
        labelNotes()
    }
    
    func labelNotes() {
        for noteButton in pianoView.noteButtons {
            labelForPreferences(noteButton)
        }
    }
    
    func colorForPreferences(_ noteButton: NoteButton) -> [KeyColorPair] {
        if Preferences.highlightTriads && highlightedScale != nil {
            let index = highlightedScale?.indexOf(noteButton.note!)
            if index == nil {
                return [KeyColorPair(whiteKeyColor: Colors.highlightedWhiteKeyColor, blackKeyColor: Colors.highlightedBlackKeyColor)]
            }
            // 0, 2, 4
            // 1, 3, 5
            // 2, 4, 6
            // 3, 5, 0
            // 4, 6, 1
            // 5, 0, 2
            // 6, 1, 3
            var colors = [KeyColorPair]()
            if ([0, 2, 4].contains(index!)) {
                colors.append(Colors.triadColors[0])
            }
            if ([1, 3, 5].contains(index!)) {
                colors.append(Colors.triadColors[1])
            }
            if ([2, 4, 6].contains(index!)) {
                colors.append(Colors.triadColors[2])
            }
            if ([3, 5, 0].contains(index!)) {
                colors.append(Colors.triadColors[3])
            }
            if ([4, 6, 1].contains(index!)) {
                colors.append(Colors.triadColors[4])
            }
            if ([5, 0, 2].contains(index!)) {
                colors.append(Colors.triadColors[5])
            }
            if ([6, 1, 3].contains(index!)) {
                colors.append(Colors.triadColors[6])
            }
            return colors
        }
        return [KeyColorPair(whiteKeyColor: Colors.highlightedWhiteKeyColor, blackKeyColor: Colors.highlightedBlackKeyColor)]
    }
    
    func labelForPreferences(_ noteButton: NoteButton) {
        var title = ""
        if Preferences.labelNoteLetter {
            title = (noteButton.note?.simpleDescription())!
        }
        if Preferences.labelNoteNumber {
            let index = highlightedScale?.indexOf(noteButton.note!)
            if (highlightedScale != nil && index != nil) {
                title += String(index! + 1)
            }
        }
        noteButton.label(title)
    }
    
    func removeLabelNotes() {
        for noteButton in pianoView.noteButtons {
            noteButton.label("")
        }
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        clearHighlighting()
        removeLabelNotes()
    }

}
