//
//  PianoNavigationViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/23/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class PianoNavigationViewController: UINavigationController, AudioEngineDelegate {
    let customNavigationBar = UINavigationBar(frame: Dimensions.toolbarRect)
    let customNavigationItem = UINavigationItem(title: "Piano")
    let menuButton = UIButton(frame: Dimensions.menuButtonRect)
    let addChordButton = UIButton(frame: Dimensions.rightBarButtonRect)
    let cancelChordButton = UIButton(frame: Dimensions.menuButtonRect)
    let saveChordButton = UIButton(frame: Dimensions.rightBarButtonRect)
    let addScaleButton = UIButton(frame: Dimensions.rightBarButtonRect)
    let cancelScaleButton = UIButton(frame: Dimensions.menuButtonRect)
    let saveScaleButton = UIButton(frame: Dimensions.rightBarButtonRect)
    let playButton = UIButton(frame: Dimensions.rightBarButtonRect)
    var chordTableViewController: ChordTableViewController?
    var chordSelectorViewController: ChordSelectorViewController?
    var chordViewController: ChordViewController?
    var identifyViewController: IdentifyViewController?
    var scaleTableViewController: ScaleTableViewController?
    var scaleSelectorViewController: ScaleSelectorViewController?
    var scaleViewController: ScaleViewController?
    var slideMenuViewController: SlideMenuViewController?
    var settingsViewController: SettingsViewController?
    var playing = false
    var audioEngine: AudioEngine?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        chordViewController = rootViewController as? ChordViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        UINavigationBar.appearance().titleTextAttributes = ["Font": Fonts.changeToolbarAction!]
        navigationController?.navigationBar.hidden = true
        customNavigationBar.translucent = false
        customNavigationBar.barTintColor = Colors.toolBarBackground
        customNavigationBar.setItems([customNavigationItem], animated: false)
        view.addSubview(customNavigationBar)
        
        menuButton.setTitle("\u{f0c9}", forState: UIControlState.Normal)
        menuButton.titleLabel!.font = Fonts.menuButton
        menuButton.setTitleColor(Colors.normalMenuButtonColor, forState: UIControlState.Normal)
        menuButton.setTitleColor(Colors.presssedMenuButtonColor, forState: UIControlState.Highlighted)
        menuButton.addTarget(self, action: #selector(toggleSlideMenuPanel), forControlEvents: UIControlEvents.TouchUpInside)
        
        addChordButton.addTarget(self, action: #selector(goToChordSelector), forControlEvents: UIControlEvents.TouchUpInside)
        cancelChordButton.setTitle("Cancel", forState: UIControlState.Normal)
        cancelChordButton.sizeToFit()
        cancelChordButton.setTitleColor(Colors.normalRightBarButtonColor, forState: UIControlState.Normal)
        cancelChordButton.setTitleColor(Colors.pressedRightBarButtonColor, forState: UIControlState.Highlighted)
        cancelChordButton.addTarget(self, action: #selector(cancelChordToProgression), forControlEvents: UIControlEvents.TouchUpInside)
        saveChordButton.setTitle("Save", forState: UIControlState.Normal)
        saveChordButton.sizeToFit()
        saveChordButton.setTitleColor(Colors.normalRightBarButtonColor, forState: UIControlState.Normal)
        saveChordButton.setTitleColor(Colors.pressedRightBarButtonColor, forState: UIControlState.Highlighted)
        saveChordButton.addTarget(self, action: #selector(addChordToProgression), forControlEvents: UIControlEvents.TouchUpInside)
        
        addScaleButton.addTarget(self, action: #selector(goToScaleSelector), forControlEvents: UIControlEvents.TouchUpInside)
        cancelScaleButton.setTitle("Cancel", forState: UIControlState.Normal)
        cancelScaleButton.sizeToFit()
        cancelScaleButton.setTitleColor(Colors.normalRightBarButtonColor, forState: UIControlState.Normal)
        cancelScaleButton.setTitleColor(Colors.pressedRightBarButtonColor, forState: UIControlState.Highlighted)
        cancelScaleButton.addTarget(self, action: #selector(cancelScaleToProgression), forControlEvents: UIControlEvents.TouchUpInside)
        saveScaleButton.setTitle("Save", forState: UIControlState.Normal)
        saveScaleButton.sizeToFit()
        saveScaleButton.setTitleColor(Colors.normalRightBarButtonColor, forState: UIControlState.Normal)
        saveScaleButton.setTitleColor(Colors.pressedRightBarButtonColor, forState: UIControlState.Highlighted)
        saveScaleButton.addTarget(self, action: #selector(addScaleToProgression), forControlEvents: UIControlEvents.TouchUpInside)
        
        playButton.setTitle("\u{f144}", forState: UIControlState.Normal)
        playButton.titleLabel!.font = Fonts.playButton
        playButton.sizeToFit()
        playButton.setTitleColor(Colors.normalPlayButtonColor, forState: UIControlState.Normal)
        playButton.setTitleColor(Colors.pressedPlayButtonColor, forState: UIControlState.Normal)
        playButton.addTarget(self, action: #selector(togglePlay), forControlEvents: UIControlEvents.TouchUpInside)
        
        // Create Controllers
        chordTableViewController = ChordTableViewController()
        scaleTableViewController = ScaleTableViewController()
        scaleViewController = ScaleViewController()
        identifyViewController = IdentifyViewController()
        slideMenuViewController = SlideMenuViewController()
        slideMenuViewController!.pianoNavigationController = self
        
        let storyboard = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
        settingsViewController = storyboard.instantiateViewControllerWithIdentifier("settingsStoryboard") as? SettingsViewController
        
        // Load Previous Session
        let chords = Session.loadChords()
        let scales = Session.loadScales()
        if chords != nil {
            chordTableViewController?.chords = chords!
            chordViewController?.chords = chords!
        }
        if scales != nil {
            scaleTableViewController?.scales = scales!
            scaleViewController?.scales = scales!
        }
        
        audioEngine = AudioEngine()
        audioEngine?.delegate = self
    }
    
    func addSlideMenuPanel() {
        if !parentViewController!.childViewControllers.contains(slideMenuViewController!) {
            parentViewController!.addChildViewController(slideMenuViewController!)
            slideMenuViewController?.didMoveToParentViewController(self)
        }
        parentViewController!.view.insertSubview((slideMenuViewController?.view)!, atIndex: 0)
    }
    
    func removeSlideMenuPanel() {
        if parentViewController!.childViewControllers.contains(slideMenuViewController!) {
            slideMenuViewController!.removeFromParentViewController()
            slideMenuViewController?.didMoveToParentViewController(self)
        }
    }
    
    func toggleSlideMenuPanel() {
        addSlideMenuPanel()
        slideMenuViewController?.togglePanel()
    }
    
    func goToChordTableView() {
        stopPlaying()
        customNavigationItem.titleView = nil
        popViewControllerAnimated(false)
        pushViewController(chordTableViewController!, animated: false)
        chordTableViewController?.updateNavigationItem()
    }
    
    func goToScaleTableView() {
        stopPlaying()
        customNavigationItem.titleView = nil
        popViewControllerAnimated(false)
        pushViewController(scaleTableViewController!, animated: false)
        scaleTableViewController?.updateNavigationItem()
    }
    
    func goToScaleView() {
        stopPlaying()
        popViewControllerAnimated(false)
        pushViewController(scaleViewController!, animated: false)
        scaleViewController?.scales = (scaleTableViewController?.scales)!
        scaleViewController?.updateNavigationItem()
        scaleViewController?.highlightScale(nil)
    }
    
    func goToChordView() {
        stopPlaying()
        popToRootViewControllerAnimated(false)
        chordViewController?.chords = (chordTableViewController?.chords)!
        chordViewController?.updateNavigationItem()
        chordViewController?.highlightChord(nil)
    }
    
    func goToIdentifyView() {
        stopPlaying()
        popViewControllerAnimated(false)
        pushViewController(identifyViewController!, animated: false)
        identifyViewController?.updateNavigationItem()
    }
    
    func goToSettingsView() {
        stopPlaying()
        popViewControllerAnimated(false)
        pushViewController(settingsViewController!, animated: false)
        settingsViewController?.updateNavigationItem()
    }
    
    func goToChordSelector() {
        removeSlideMenuPanel()
        popViewControllerAnimated(false)
        if (chordSelectorViewController == nil) {
            let storyboard = UIStoryboard(name: "ChordSelectorStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("chordSelectorStoryboard")
            chordSelectorViewController = vc as? ChordSelectorViewController
        }
        pushViewController(chordSelectorViewController!, animated: false)
        chordSelectorViewController?.updateNavigationItem()
    }
    
    func goToScaleSelector() {
        removeSlideMenuPanel()
        popViewControllerAnimated(false)
        if (scaleSelectorViewController == nil) {
            let storyboard = UIStoryboard(name: "ScaleSelectorStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("scaleSelectorStoryboard")
            scaleSelectorViewController = vc as? ScaleSelectorViewController
        }
        pushViewController(scaleSelectorViewController!, animated: false)
        scaleSelectorViewController?.updateNavigationItem()
    }
    
    func addChordToProgression() {
        let rootNote = chordSelectorViewController?.rootNotePickerView.selectedRowInComponent(0)
        let chordType = chordSelectorViewController?.chordTypePickerView.selectedRowInComponent(0)
        let chord = ChordGenerator.generateChord(Note(rawValue: rootNote!)!, chordType: ChordType(rawValue: chordType!)!)
        chordTableViewController?.chords.append(chord)
        chordTableViewController?.tableView!.reloadData()
        popViewControllerAnimated(false)
        pushViewController(chordTableViewController!, animated: false)
        chordTableViewController?.updateNavigationItem()
        Session.save(chords: chordTableViewController?.chords)
    }
    
    func cancelChordToProgression() {
        popViewControllerAnimated(false)
        pushViewController(chordTableViewController!, animated: false)
        chordTableViewController?.updateNavigationItem()
    }
    
    func addScaleToProgression() {
        let rootNote = scaleSelectorViewController?.rootNotePickerView.selectedRowInComponent(0)
        let scaleType = scaleSelectorViewController?.scaleTypePickerView.selectedRowInComponent(0)
        let scale = ScaleGenerator.generateScale(Note(rawValue: rootNote!)!, scaleType: ScaleType(rawValue: scaleType!)!)
        scaleTableViewController?.scales.append(scale)
        scaleTableViewController?.tableView!.reloadData()
        popViewControllerAnimated(false)
        pushViewController(scaleTableViewController!, animated: false)
        scaleTableViewController?.updateNavigationItem()
        Session.save(scaleTableViewController?.scales)
    }
    
    func cancelScaleToProgression() {
        popViewControllerAnimated(false)
        pushViewController(scaleTableViewController!, animated: false)
        scaleTableViewController?.updateNavigationItem()
    }
    
    func startPlaying() {
        if (!playing) {
            playing = true
            playButton.setTitle("\u{f28d}", forState: UIControlState.Normal)
            if (topViewController is ScaleViewController) {
                let pianoView = scaleViewController?.pianoView
                let notes = NoteOctaveDetector.determineNoteOctavesOnScreen(pianoView!)
                audioEngine?.play(notes, isScale: true)
            } else {
                let pianoView = chordViewController?.pianoView
                let notes = NoteOctaveDetector.determineNoteOctavesOnScreen(pianoView!)
                audioEngine?.play(notes)
            }
        }
    }
    
    func stopPlaying() {
        if (playing) {
            playing = false
            audioEngine?.stop()
            let highlightedNoteButtons = topPianoView()?.highlightedNoteButtons
            for button in highlightedNoteButtons! {
                dispatch_async(dispatch_get_main_queue(), {
                    button.dehighlightBorder()
                })
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.playButton.setTitle("\u{f144}", forState: UIControlState.Normal)
            })
        }
    }
    
    func togglePlay() {
        if (!playing) {
            startPlaying()
        } else {
            stopPlaying()
        }
    }
    
    func didFinishPlaying() {
        stopPlaying()
    }
    
    func didFinishPlayingNotes(notes: [NoteOctave]) {
        for note in notes {
            let finishedButtons = topPianoView()?.highlightedNoteButtons.filter({$0.noteOctave! == note})
            for button in finishedButtons! {
                dispatch_async(dispatch_get_main_queue(), {
                    button.dehighlightBorder()
                })
            }
        }
    }
    
    func didStartPlayingNotes(notes: [NoteOctave]) {
        if (playing) {
            for note in notes {
                let startedButtons = topPianoView()?.highlightedNoteButtons.filter({$0.noteOctave! == note})
                for button in startedButtons! {
                    dispatch_async(dispatch_get_main_queue(), {
                        button.highlightBorder()
                    })
                }
            }
        }
    }
    
    func topPianoView() -> PianoView? {
        if (topViewController is ScaleViewController) {
            return (topViewController as! ScaleViewController).pianoView
        }
        if (topViewController is ChordViewController) {
            return (topViewController as! ChordViewController).pianoView
        }
        return nil
    }
}
