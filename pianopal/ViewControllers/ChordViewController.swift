//
//  ChordViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/23/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class ChordViewController: UIViewController, PianoNavigationProtocol {
    let pianoView = PianoView(frame: Dimensions.pianoRect)
    var pianoNavigationViewController: PianoNavigationViewController?
    var menuBarButton: UIBarButtonItem?
    var changeModeBarButton: UIBarButtonItem?
    var chords = [Chord]()
    var chordsScrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        updateNavigationItem()
        view.addSubview(pianoView)
    }
    
    func updateNavigationItem() {
        pianoNavigationViewController = (navigationController as! PianoNavigationViewController)
        menuBarButton = UIBarButtonItem(customView: pianoNavigationViewController!.menuButton)
        changeModeBarButton = UIBarButtonItem(customView: pianoNavigationViewController!.changeModeButton)
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = menuBarButton
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = changeModeBarButton
        if chords.isEmpty {
            pianoNavigationViewController!.customNavigationItem.title = "Piano Chords"
        } else {
            setUpChordScrollView()
        }
    }
    
    func setUpChordScrollView() {
        chordsScrollView = UIScrollView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
//        chordsScrollView?.delegate = self
//        chordsScrollView?.
        chordsScrollView!.backgroundColor = UIColor.blueColor()
        pianoNavigationViewController!.customNavigationItem.titleView = chordsScrollView!
    }
    
    func highlightChord() {
        // TODO
        let chord = chords.first
        if (chord == nil) {
            return
        }
        for noteButton in pianoView.noteButtons {
            if chord!.notes.contains(noteButton.note!) {
                pianoView.highlightedNoteButtons.append(noteButton)
                dispatch_async(dispatch_get_main_queue(), {
                    noteButton.backgroundColor = Colors.chordColor
                })
            }
        }
    }
}
