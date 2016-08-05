//
//  IdentifyViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/23/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class IdentifyViewController: UIViewController, PianoNavigationProtocol {
    let pianoView = PianoView(frame: Dimensions.pianoRect)
    var pianoNavigationViewController: PianoNavigationViewController?
    var menuBarButton: UIBarButtonItem?
    var changeModeBarButton: UIBarButtonItem?
    var notesToIdentify = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.interactivePopGestureRecognizer?.enabled = false
        updateNavigationItem()
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(pianoView)
    }
    
    func setUpIdentifyMode() {
        clearHighlighting()
        for noteButton in pianoView.noteButtons {
            noteButton.addTarget(self, action: #selector(noteSelectedForIdentification), forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    func noteSelectedForIdentification(sender: NoteButton) {
        if sender.illuminated {
            sender.deIlluminate()
            notesToIdentify.removeAtIndex(notesToIdentify.indexOf(sender.note!)!)
        } else {
            sender.illuminate([KeyColorPair(whiteKeyColor: Colors.highlightedWhiteKeyColor, blackKeyColor: Colors.highlightedBlackKeyColor)])
            notesToIdentify.append(sender.note!)
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                let identifiedChord = ChordIdentifier.chordForNotes(self.notesToIdentify)
                var chordDescription: String?
                if identifiedChord == nil {
                    chordDescription = "N/A"
                } else {
                    chordDescription = identifiedChord?.simpleDescription()
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.pianoNavigationViewController?.customNavigationItem.title = chordDescription
                })
            })
        }
    }
    
    func clearHighlighting() {
        for noteButton in pianoView.highlightedNoteButtons {
            dispatch_async(dispatch_get_main_queue(), {
                noteButton.deIlluminate()
            })
        }
        pianoView.highlightedNoteButtons.removeAll()
    }
    
    func updateNavigationItem() {
        pianoNavigationViewController = (navigationController as! PianoNavigationViewController)
        pianoNavigationViewController?.customNavigationItem.titleView = nil
        pianoNavigationViewController!.customNavigationItem.title = "Identify Chords"

        menuBarButton = UIBarButtonItem(customView: pianoNavigationViewController!.menuButton)
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = menuBarButton
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = nil
        setUpIdentifyMode()
    }
    
    func labelNotes() {
        for noteButton in pianoView.noteButtons {
            labelForPreferences(noteButton)
        }
    }
    
    func labelForPreferences(noteButton: NoteButton) {
        var title = ""
        if Preferences.labelNoteLetter {
            title += (noteButton.note?.simpleDescription())!
        }
        noteButton.label(title)
    }
    
    func removeLabelNotes() {
        for noteButton in pianoView.noteButtons {
            noteButton.label("")
        }
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        removeLabelNotes()
        labelNotes()
    }

}
