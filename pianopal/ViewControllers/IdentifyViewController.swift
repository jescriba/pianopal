////
////  IdentifyViewController.swift
////  pianopal
////
////  Created by Joshua Escribano on 7/23/16.
////  Copyright © 2016 Joshua Escribano. All rights reserved.
////
//
//import UIKit
//
//class IdentifyViewController: UIViewController, PianoNavigationProtocol {
//    let pianoView = PianoView(frame: Dimensions.pianoRect)
//    var pianoNavigationViewController: PianoNavigationViewController?
//    var menuBarButton: UIBarButtonItem?
//    var changeModeBarButton: UIBarButtonItem?
//    var playBarButton: UIBarButtonItem?
//    var notesToIdentify = [Note]()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        navigationController!.interactivePopGestureRecognizer?.isEnabled = false
//        updateNavigationItem()
//        automaticallyAdjustsScrollViewInsets = false
//        view.addSubview(pianoView)
//    }
//    
//    func setUpIdentifyMode() {
//        clearHighlighting()
//        for noteButton in pianoView.noteButtons {
//            noteButton.addTarget(self, action: #selector(noteSelectedForIdentification), for: UIControlEvents.touchUpInside)
//        }
//    }
//    
//    func noteSelectedForIdentification(_ sender: NoteButton) {
//        if sender.illuminated {
//            sender.deIlluminate()
//            pianoView.highlightedNoteButtons.remove(at: pianoView.highlightedNoteButtons.index(of: sender)!)
//            notesToIdentify.remove(at: notesToIdentify.index(of: sender.note!)!)
//        } else {
//            sender.illuminate([KeyColorPair(whiteKeyColor: Colors.highlightedWhiteKeyColor, blackKeyColor: Colors.highlightedBlackKeyColor)])
//            pianoView.highlightedNoteButtons.append(sender)
//            notesToIdentify.append(sender.note!)
//            DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: {
//                let identifiedChord = ChordIdentifier.chordForNotes(self.notesToIdentify)
//                var chordDescription: String?
//                if identifiedChord == nil {
//                    chordDescription = "N/A"
//                } else {
//                    chordDescription = identifiedChord?.simpleDescription()
//                }
//                DispatchQueue.main.async(execute: {
//                    self.pianoNavigationViewController?.customNavigationItem.title = chordDescription
//                })
//            })
//        }
//    }
//    
//    func clearHighlighting() {
//        for noteButton in pianoView.highlightedNoteButtons {
//            DispatchQueue.main.async(execute: {
//                noteButton.deIlluminate()
//            })
//        }
//        pianoView.highlightedNoteButtons.removeAll()
//    }
//    
//    func updateNavigationItem() {
//        pianoNavigationViewController = (navigationController as! PianoNavigationViewController)
//        pianoNavigationViewController?.customNavigationItem.titleView = nil
//        pianoNavigationViewController!.customNavigationItem.title = "Identify Chords"
//
//        menuBarButton = UIBarButtonItem(customView: pianoNavigationViewController!.menuButton)
//        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = menuBarButton
//        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = nil
//        playBarButton = UIBarButtonItem(customView: pianoNavigationViewController!.playButton)
//        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = playBarButton
//        setUpIdentifyMode()
//    }
//    
//    func labelNotes() {
//        for noteButton in pianoView.noteButtons {
//            labelForPreferences(noteButton)
//        }
//    }
//    
//    func labelForPreferences(_ noteButton: NoteButton) {
//        var title = ""
//        if Preferences.labelNoteLetter {
//            title += (noteButton.note?.simpleDescription())!
//        }
//        noteButton.label(title)
//    }
//    
//    func removeLabelNotes() {
//        for noteButton in pianoView.noteButtons {
//            noteButton.label("")
//        }
//    }
//    
//    override func didMove(toParentViewController parent: UIViewController?) {
//        removeLabelNotes()
//        labelNotes()
//    }
//
//}
