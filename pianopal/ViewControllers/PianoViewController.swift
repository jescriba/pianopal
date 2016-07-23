//
//  PianoScrollViewController.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/12/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class PianoViewController : UIViewController, UIScrollViewDelegate {
    var scrollView = UIScrollView()
    var leftPianoView = UIView()
    var centerPianoView = UIView()
    var rightPianoView = UIView()
    var toolbarView = UIView()
    var toolbarActionButton = UIButton()
    var toolbarActionType = ToolbarActionType.Chord
    var changeToolbarActionButton = UIButton()
    var noteButtons = [NoteButton]()
    var highlightedNoteButtons = [NoteButton]()
    var selectedNotesToIdentify = [Note]()
    var chord: Chord?
    var scale: Scale?
    var chords: [Chord]?
    var scales: [Scale]?
    
    convenience init(scale: Scale) {
        self.init(nibName: nil, bundle: nil)
        self.scale = scale
        self.toolbarActionType = ToolbarActionType.Scale
        setToolbarTitleAndResizeToolbar(scale.simpleDescription())
    }
    
    convenience init(chord: Chord) {
        self.init(nibName: nil, bundle: nil)
        self.chord = chord
        self.toolbarActionType = ToolbarActionType.Chord
        setToolbarTitleAndResizeToolbar(chord.simpleDescription())
    }
    
    convenience init(chords: [Chord]) {
        self.init(nibName: nil, bundle: nil)
        self.chord = chords.first
        self.chords = chords
        self.toolbarActionType = ToolbarActionType.Chord
        // TODO
        // Implement ScrollView Toolbar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    func setUpView()
    {
        toolbarView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height / CGFloat(8)))
        toolbarActionButton = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: toolbarView.bounds.height))
        changeToolbarActionButton = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: toolbarView.bounds.height))
        toolbarView.backgroundColor = Colors.toolBarBackground
        toolbarActionButton.backgroundColor = Colors.toolBarBackground
        changeToolbarActionButton.backgroundColor = Colors.toolBarBackground
        let changeModeButton = UIButton(frame: CGRect(x: UIScreen.mainScreen().bounds.width - 50, y: 0, width: 50, height: UIScreen.mainScreen().bounds.height / CGFloat(8)))
        changeModeButton.backgroundColor = Colors.toolBarBackground
        changeModeButton.titleLabel?.font = Fonts.changeModeButton
        changeModeButton.setTitle("\u{f105}", forState: UIControlState.Normal)
        changeModeButton.setTitleColor(Colors.normalChangeModeColor, forState: UIControlState.Normal)
        changeModeButton.setTitleColor(Colors.pressedChangeModeColor, forState: UIControlState.Highlighted)
        changeModeButton.addTarget(self, action: #selector(changeToolbarAction), forControlEvents: UIControlEvents.TouchUpInside)
        toolbarView.addSubview(changeModeButton)
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: UIScreen.mainScreen().bounds.height / CGFloat(8)))
        menuButton.backgroundColor = Colors.toolBarBackground
        menuButton.titleLabel?.font = Fonts.menuButton
        menuButton.setTitle("\u{f0c9}", forState: UIControlState.Normal)
        menuButton.setTitleColor(Colors.normalMenuButtonColor, forState: UIControlState.Normal)
        menuButton.setTitleColor(Colors.presssedMenuButtonColor, forState: UIControlState.Highlighted)
        menuButton.addTarget(self, action: #selector(menuAction), forControlEvents: UIControlEvents.TouchUpInside)
        toolbarView.addSubview(menuButton)
        var centerDescription: String?
        if self.chord != nil {
            centerDescription = self.chord!.simpleDescription()
        } else {
            centerDescription = self.scale!.simpleDescription()
        }
        toolbarActionButton.setTitle(centerDescription, forState: UIControlState.Normal)
        toolbarActionButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        changeToolbarActionButton.setTitle("\(self.toolbarActionType)", forState: UIControlState.Normal)
        changeToolbarActionButton.setTitleColor(Colors.changeToolbarActionText, forState: UIControlState.Normal)
        toolbarActionButton.titleLabel?.font = Fonts.toolbarAction
        changeToolbarActionButton.titleLabel?.font = Fonts.changeToolbarAction
        toolbarActionButton.titleLabel?.textAlignment = NSTextAlignment.Center
        changeToolbarActionButton.titleLabel?.textAlignment = NSTextAlignment.Center
        toolbarActionButton.sizeToFit()
        changeToolbarActionButton.sizeToFit()
        toolbarActionButton.frame.size.height = toolbarView.frame.height
        changeToolbarActionButton.frame.size.height = toolbarView.frame.height
        toolbarActionButton.center.x = toolbarView.center.x
        changeToolbarActionButton.frame.origin.x = toolbarActionButton.frame.maxX + 10.0
        toolbarActionButton.addTarget(self, action: #selector(toolbarAction), forControlEvents: UIControlEvents.TouchUpInside)
        changeToolbarActionButton.addTarget(self, action: #selector(changeToolbarAction), forControlEvents: UIControlEvents.TouchUpInside)
        toolbarView.addSubview(toolbarActionButton)
        toolbarView.addSubview(changeToolbarActionButton)
        toolbarView.userInteractionEnabled = true
        scrollView.frame = UIScreen.mainScreen().bounds
        scrollView.maximumZoomScale = 1
        scrollView.minimumZoomScale = 1
        scrollView.contentSize.width = scrollView.frame.width * 3
        scrollView.contentSize.height = scrollView.frame.height
        scrollView.contentOffset = CGPoint(x: scrollView.frame.width, y: 0)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.decelerationRate = 0.98
        scrollView.bounces = false
        scrollView.delegate = self
        
        rightPianoView = setUpOctaveView(2)
        centerPianoView = setUpOctaveView(1)
        leftPianoView = setUpOctaveView(0)
        scrollView.addSubview(leftPianoView)
        scrollView.addSubview(centerPianoView)
        scrollView.addSubview(rightPianoView)
        
        let doubleTapScrollViewRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleSoloPianoView))
        doubleTapScrollViewRecognizer.delaysTouchesBegan = true
        doubleTapScrollViewRecognizer.numberOfTapsRequired = 2
        doubleTapScrollViewRecognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(doubleTapScrollViewRecognizer)
        
        view.addSubview(scrollView)
        view.addSubview(toolbarView)
        
        highlightChord(self.chord)
        highlightScale(self.scale)
        
        let launchedBefore = NSUserDefaults.standardUserDefaults().boolForKey("launchedBefore")
        if !launchedBefore  {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "launchedBefore")
            setToolbarTitleAndResizeToolbar("Generate Chords")
            setChangeToolbarTitleAndResizeToolbar("Generate Scales")
            dispatch_async(dispatch_get_main_queue(), {
                self.toolbarActionButton.center = CGPoint(x: self.toolbarActionButton.frame.width / 1.2, y: self.toolbarActionButton.frame.height / 2)
                self.changeToolbarActionButton.center = CGPoint(x: self.toolbarActionButton.frame.maxX + self.changeToolbarActionButton.frame.width / 2 + 10, y: self.changeToolbarActionButton.frame.height / 2 )
            })
            
        } else {
            toolbarActionButton.center.x = toolbarView.center.x
            changeToolbarActionButton.frame.origin.x = toolbarActionButton.frame.maxX + 10.0
        }

    }
    
    func menuAction() {
        switch toolbarActionType {
        case .Chord:
            goToChordMenuViewController()
        case .Scale:
            goToScaleMenuViewController()
        case .Identify:
            goToIdentifyMenuViewController()
        }
    }
    
    func toolbarAction() {
        switch toolbarActionType {
        case .Chord:
            goToChordSelectorViewController()
        case .Scale:
            goToScaleSelectorViewController()
        case .Identify:
            setUpIdentifyMode()
        }
    }
    
    func setUpChordMode() {
        var chordName: String?
        if chord == nil {
            chordName = "Generate"
        } else {
            chordName = chord?.simpleDescription()
            highlightChord(chord)
        }
        setToolbarTitleAndResizeToolbar("\(chordName!)")
    }
    
    func setUpScaleMode() {
        if toolbarActionType == .Scale && chord != nil {
            var scaleType: ScaleType?
            if chord!.simpleDescription().containsString("Major") {
                scaleType = ScaleType.Major
            } else if chord!.simpleDescription().containsString("Minor") {
                scaleType = ScaleType.NaturalMinor
            } else {
                scaleType = ScaleType.Major
            }
            let generatedScale = ScaleGenerator.generateScale(chord!.notes.first!, scaleType: scaleType!)
            highlightScale(generatedScale)
            setToolbarTitleAndResizeToolbar(generatedScale.simpleDescription())
        }
    }
    
    func setUpIdentifyMode() {
        setToolbarTitleAndResizeToolbar("Tap keys to")
        for noteButton in noteButtons {
            noteButton.addTarget(self, action: #selector(noteSelectedForIdentification), forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    func noteSelectedForIdentification(sender: NoteButton) {
        if sender.backgroundColor == Colors.identificationColor {
            // Turn Off since already on
            sender.backgroundColor = sender.determineNoteColor(sender.note!)
            selectedNotesToIdentify.removeAtIndex(selectedNotesToIdentify.indexOf(sender.note!)!)
        } else {
            // Turn On since current off
            sender.backgroundColor = Colors.identificationColor
            selectedNotesToIdentify.append(sender.note!)
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let identifiedChord = ChordIdentifier.chordForNotes(self.selectedNotesToIdentify)
            var chordDescription: String?
            if identifiedChord == nil {
                chordDescription = "N/A"
            } else {
                chordDescription = identifiedChord?.simpleDescription()
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.setToolbarTitleAndResizeToolbar(chordDescription!)
            })
        })
    }
    
    func setToolbarTitleAndResizeToolbar(title: String) {
        dispatch_async(dispatch_get_main_queue(), {
            self.toolbarActionButton.setTitle(title, forState: UIControlState.Normal)
            self.toolbarActionButton.sizeToFit()
            self.toolbarActionButton.center.x = self.toolbarView.center.x
            self.changeToolbarActionButton.frame.origin.x = self.toolbarActionButton.frame.maxX + 10.0
            self.toolbarActionButton.frame.size.height = self.toolbarView.frame.size.height
        })
    }
    
    func setChangeToolbarTitleAndResizeToolbar(title: String) {
        dispatch_async(dispatch_get_main_queue(), {
            self.changeToolbarActionButton.setTitle(title, forState: UIControlState.Normal)
            self.changeToolbarActionButton.sizeToFit()
            self.toolbarActionButton.center.x = self.toolbarView.center.x
            self.changeToolbarActionButton.frame.origin.x = self.toolbarActionButton.frame.maxX + 10.0
            self.changeToolbarActionButton.frame.size.height = self.toolbarView.frame.size.height
        })
    }
    
    func removeNoteButtonTargets() {
        for noteButton in noteButtons {
            dispatch_async(dispatch_get_main_queue(), {
                noteButton.backgroundColor = noteButton.determineNoteColor(noteButton.note!)
            })
            noteButton.removeTarget(self, action: #selector(noteSelectedForIdentification), forControlEvents: UIControlEvents.TouchUpInside)
        }
        selectedNotesToIdentify.removeAll()
    }
    
    func changeToolbarAction() {
        removeNoteButtonTargets()
        clearHighlighting()
        switch toolbarActionType {
        case .Chord:
            toolbarActionType = .Scale
            setUpScaleMode()
        case .Scale:
            toolbarActionType = .Identify
            setUpIdentifyMode()
        case .Identify:
            toolbarActionType = .Chord
            setUpChordMode()
        }
        setChangeToolbarTitleAndResizeToolbar("\(self.toolbarActionType)")
    }
    
    func toggleSoloPianoView() {
        if view.subviews.contains(toolbarView) {
            toolbarView.removeFromSuperview()
            for noteButton in noteButtons {
                noteButton.titleLabel?.text = ""
            }
        } else {
            view.addSubview(toolbarView)
            for noteButton in noteButtons {
                noteButton.titleLabel?.text = noteButton.note?.simpleDescription()
            }
        }
    }
    
    func goToChordSelectorViewController() {
        let chordSelectorStoryboard = UIStoryboard.init(name: "ChordSelectorStoryboard", bundle: nil)
        let chordSelectorViewController = chordSelectorStoryboard.instantiateViewControllerWithIdentifier("chordSelectorStoryboard")
        UIApplication.sharedApplication().delegate!.window!?.rootViewController = chordSelectorViewController
    }
    
    func goToScaleSelectorViewController() {
        let scaleSelectorStoryboard = UIStoryboard.init(name: "ScaleSelectorStoryboard", bundle: nil)
        let scaleSelectorViewController = scaleSelectorStoryboard.instantiateViewControllerWithIdentifier("scaleSelectorStoryboard")
        UIApplication.sharedApplication().delegate!.window!?.rootViewController = scaleSelectorViewController
    }
    
    func goToChordMenuViewController() {
        let chordMenuStoryboard = UIStoryboard.init(name: "ChordProgressionListStoryboard", bundle: nil)
        let chordMenuViewController = chordMenuStoryboard.instantiateViewControllerWithIdentifier("chordProgressionListStoryboard")
        UIApplication.sharedApplication().delegate!.window?!.rootViewController = ChordMenuNavigationController(rootViewController: chordMenuViewController)
    }
    
    func goToScaleMenuViewController() {
        
    }
    
    func goToIdentifyMenuViewController() {
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        switch scrollView.contentOffset.x {
        case scrollView.frame.width * 2, 0:
            scrollView.setContentOffset(CGPoint(x: scrollView.frame.width, y: 0), animated: false)
            break
        default:
            break
        }
    }
    
    func setUpOctaveView(position: Int) -> UIView {
        let height = scrollView.frame.height
        let width = scrollView.frame.width
        let offset = CGFloat(position) * scrollView.frame.width
        let octaveView = UIView(frame: CGRect(x: offset, y: 0, width: width, height: height))
        for note in Constants.orderedNotes {
            let buttonFrame = CGRect(x: width * KeyProperties.x(note), y: height * KeyProperties.y(note), width: width * KeyProperties.width(note), height: height * KeyProperties.height(note))
            let button = NoteButton(frame: buttonFrame, note: note)
            noteButtons.append(button)
            octaveView.addSubview(button)
        }
        return octaveView
    }
    
    func clearHighlighting() {
        for noteButton in highlightedNoteButtons {
            dispatch_async(dispatch_get_main_queue(), {
                noteButton.backgroundColor = noteButton.determineNoteColor(noteButton.note!)
            })
        }
        highlightedNoteButtons.removeAll()
    }
    
    func highlightScale(scale: Scale?) {
        if (scale == nil) {
            return
        }
        for noteButton in noteButtons {
            if scale!.notes.contains(noteButton.note!) {
                highlightedNoteButtons.append(noteButton)
                dispatch_async(dispatch_get_main_queue(), {
                    noteButton.backgroundColor = Colors.scaleColor
                })
            }
        }
    }
    
    func highlightChord(chord: Chord?) {
        if (chord == nil) {
            return
        }
        for noteButton in noteButtons {
            if chord!.notes.contains(noteButton.note!) {
                highlightedNoteButtons.append(noteButton)
                dispatch_async(dispatch_get_main_queue(), {
                    noteButton.backgroundColor = Colors.chordColor
                })
            }
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        dispatch_async(dispatch_get_main_queue(), {
            self.view.subviews.forEach({$0.removeFromSuperview()})
            self.scrollView.subviews.forEach({$0.removeFromSuperview()})
            self.setUpView()
        })
    }
}