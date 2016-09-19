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
    let saveSessionButton = UIButton(frame: Dimensions.rightBarButtonRect)
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
    var sessionsViewController: SessionsViewController?
    var playing = false
    var audioEngine: AudioEngine?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        chordViewController = rootViewController as? ChordViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        UINavigationBar.appearance().titleTextAttributes = ["Font": Fonts.changeToolbarAction!]
        navigationController?.navigationBar.isHidden = true
        customNavigationBar.isTranslucent = false
        customNavigationBar.barTintColor = Colors.toolBarBackground
        customNavigationBar.setItems([customNavigationItem], animated: false)
        view.addSubview(customNavigationBar)
        
        menuButton.setTitle("\u{f0c9}", for: UIControlState())
        menuButton.titleLabel!.font = Fonts.menuButton
        menuButton.setTitleColor(Colors.normalMenuButtonColor, for: UIControlState())
        menuButton.setTitleColor(Colors.presssedMenuButtonColor, for: UIControlState.highlighted)
        menuButton.addTarget(self, action: #selector(toggleSlideMenuPanel), for: UIControlEvents.touchUpInside)
        
        addChordButton.addTarget(self, action: #selector(goToChordSelector), for: UIControlEvents.touchUpInside)
        cancelChordButton.setTitle("Cancel", for: UIControlState())
        cancelChordButton.sizeToFit()
        cancelChordButton.setTitleColor(Colors.normalRightBarButtonColor, for: UIControlState())
        cancelChordButton.setTitleColor(Colors.pressedRightBarButtonColor, for: UIControlState.highlighted)
        cancelChordButton.addTarget(self, action: #selector(cancelChordToProgression), for: UIControlEvents.touchUpInside)
        saveChordButton.setTitle("Save", for: UIControlState())
        saveChordButton.sizeToFit()
        saveChordButton.setTitleColor(Colors.normalRightBarButtonColor, for: UIControlState())
        saveChordButton.setTitleColor(Colors.pressedRightBarButtonColor, for: UIControlState.highlighted)
        saveChordButton.addTarget(self, action: #selector(addChordToProgression), for: UIControlEvents.touchUpInside)
        
        addScaleButton.addTarget(self, action: #selector(goToScaleSelector), for: UIControlEvents.touchUpInside)
        cancelScaleButton.setTitle("Cancel", for: UIControlState())
        cancelScaleButton.sizeToFit()
        cancelScaleButton.setTitleColor(Colors.normalRightBarButtonColor, for: UIControlState())
        cancelScaleButton.setTitleColor(Colors.pressedRightBarButtonColor, for: UIControlState.highlighted)
        cancelScaleButton.addTarget(self, action: #selector(cancelScaleToProgression), for: UIControlEvents.touchUpInside)
        saveScaleButton.setTitle("Save", for: UIControlState())
        saveScaleButton.sizeToFit()
        saveScaleButton.setTitleColor(Colors.normalRightBarButtonColor, for: UIControlState())
        saveScaleButton.setTitleColor(Colors.pressedRightBarButtonColor, for: UIControlState.highlighted)
        saveScaleButton.addTarget(self, action: #selector(addScaleToProgression), for: UIControlEvents.touchUpInside)
        
        playButton.setTitle("\u{f144}", for: UIControlState())
        playButton.titleLabel!.font = Fonts.playButton
        playButton.sizeToFit()
        playButton.setTitleColor(Colors.normalPlayButtonColor, for: UIControlState())
        playButton.setTitleColor(Colors.pressedPlayButtonColor, for: UIControlState())
        playButton.addTarget(self, action: #selector(togglePlay), for: UIControlEvents.touchUpInside)
        
        saveSessionButton.setTitle("Save", for: UIControlState.normal)
        saveSessionButton.sizeToFit()
        saveSessionButton.setTitleColor(Colors.normalRightBarButtonColor, for: UIControlState.normal)
        saveSessionButton.setTitleColor(Colors.pressedRightBarButtonColor, for: UIControlState.highlighted)
        saveSessionButton.addTarget(self, action: #selector(saveSession), for: UIControlEvents.touchUpInside)
        
        // Create Controllers
        chordTableViewController = ChordTableViewController()
        scaleTableViewController = ScaleTableViewController()
        scaleViewController = ScaleViewController()
        identifyViewController = IdentifyViewController()
        sessionsViewController = SessionsViewController()
        slideMenuViewController = SlideMenuViewController()
        slideMenuViewController!.pianoNavigationController = self
        
        let storyboard = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
        settingsViewController = storyboard.instantiateViewController(withIdentifier: "settingsStoryboard") as? SettingsViewController
        
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
        if !parent!.childViewControllers.contains(slideMenuViewController!) {
            parent!.addChildViewController(slideMenuViewController!)
            slideMenuViewController?.didMove(toParentViewController: self)
        }
        parent!.view.insertSubview((slideMenuViewController?.view)!, at: 0)
    }
    
    func removeSlideMenuPanel() {
        if parent!.childViewControllers.contains(slideMenuViewController!) {
            slideMenuViewController!.removeFromParentViewController()
            slideMenuViewController?.didMove(toParentViewController: self)
        }
    }
    
    func toggleSlideMenuPanel() {
        addSlideMenuPanel()
        slideMenuViewController?.togglePanel()
    }
    
    func goToChordTableView() {
        stopPlaying()
        customNavigationItem.titleView = nil
        popViewController(animated: false)
        pushViewController(chordTableViewController!, animated: false)
        chordTableViewController?.updateNavigationItem()
    }
    
    func goToScaleTableView() {
        stopPlaying()
        customNavigationItem.titleView = nil
        popViewController(animated: false)
        pushViewController(scaleTableViewController!, animated: false)
        scaleTableViewController?.updateNavigationItem()
    }
    
    func goToScaleView() {
        stopPlaying()
        popViewController(animated: false)
        pushViewController(scaleViewController!, animated: false)
        scaleViewController?.scales = (scaleTableViewController?.scales)!
        scaleViewController?.updateNavigationItem()
        scaleViewController?.highlightScale(nil)
    }
    
    func goToChordView() {
        stopPlaying()
        popToRootViewController(animated: false)
        chordViewController?.chords = (chordTableViewController?.chords)!
        chordViewController?.updateNavigationItem()
        chordViewController?.highlightChord(nil)
    }
    
    func goToIdentifyView() {
        stopPlaying()
        popViewController(animated: false)
        pushViewController(identifyViewController!, animated: false)
        identifyViewController?.updateNavigationItem()
    }
    
    func goToSettingsView() {
        stopPlaying()
        popViewController(animated: false)
        pushViewController(settingsViewController!, animated: false)
        settingsViewController?.updateNavigationItem()
    }
    
    func goToSessionsView() {
        stopPlaying()
        popViewController(animated: false)
        pushViewController(sessionsViewController!, animated: false)
        sessionsViewController?.updateNavigationItem()
    }
    
    func goToChordSelector() {
        removeSlideMenuPanel()
        popViewController(animated: false)
        if (chordSelectorViewController == nil) {
            let storyboard = UIStoryboard(name: "ChordSelectorStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "chordSelectorStoryboard")
            chordSelectorViewController = vc as? ChordSelectorViewController
        }
        pushViewController(chordSelectorViewController!, animated: false)
        chordSelectorViewController?.updateNavigationItem()
    }
    
    func goToScaleSelector() {
        removeSlideMenuPanel()
        popViewController(animated: false)
        if (scaleSelectorViewController == nil) {
            let storyboard = UIStoryboard(name: "ScaleSelectorStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "scaleSelectorStoryboard")
            scaleSelectorViewController = vc as? ScaleSelectorViewController
        }
        pushViewController(scaleSelectorViewController!, animated: false)
        scaleSelectorViewController?.updateNavigationItem()
    }
    
    func saveSession() {
        
    }
    
    func addChordToProgression() {
        let rootNote = chordSelectorViewController?.rootNotePickerView.selectedRow(inComponent: 0)
        let chordType = chordSelectorViewController?.chordTypePickerView.selectedRow(inComponent: 0)
        let chord = ChordGenerator.generateChord(Note(rawValue: rootNote!)!, chordType: ChordType(rawValue: chordType!)!)
        chordTableViewController?.chords.append(chord)
        chordTableViewController?.tableView!.reloadData()
        popViewController(animated: false)
        pushViewController(chordTableViewController!, animated: false)
        chordTableViewController?.updateNavigationItem()
        Session.save(chords: chordTableViewController?.chords)
    }
    
    func cancelChordToProgression() {
        popViewController(animated: false)
        pushViewController(chordTableViewController!, animated: false)
        chordTableViewController?.updateNavigationItem()
    }
    
    func addScaleToProgression() {
        let rootNote = scaleSelectorViewController?.rootNotePickerView.selectedRow(inComponent: 0)
        let scaleType = scaleSelectorViewController?.scaleTypePickerView.selectedRow(inComponent: 0)
        let scale = ScaleGenerator.generateScale(Note(rawValue: rootNote!)!, scaleType: ScaleType(rawValue: scaleType!)!)
        scaleTableViewController?.scales.append(scale)
        scaleTableViewController?.tableView!.reloadData()
        popViewController(animated: false)
        pushViewController(scaleTableViewController!, animated: false)
        scaleTableViewController?.updateNavigationItem()
        Session.save(scaleTableViewController?.scales)
    }
    
    func cancelScaleToProgression() {
        popViewController(animated: false)
        pushViewController(scaleTableViewController!, animated: false)
        scaleTableViewController?.updateNavigationItem()
    }
    
    func startPlaying() {
        if (!playing) {
            playing = true
            playButton.setTitle("\u{f28d}", for: UIControlState())
            let pianoView = topPianoView()
            let notes = NoteOctaveDetector.determineNoteOctavesOnScreen(pianoView!)
            if (topViewController is ScaleViewController) {
                audioEngine?.play(notes, isScale: true)
            } else {
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
                DispatchQueue.main.async(execute: {
                    button.dehighlightBorder()
                })
            }
            DispatchQueue.main.async(execute: {
                self.playButton.setTitle("\u{f144}", for: UIControlState())
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
    
    func didFinishPlayingNotes(_ notes: [NoteOctave]) {
        for note in notes {
            let finishedButtons = topPianoView()?.highlightedNoteButtons.filter({$0.noteOctave! == note})
            for button in finishedButtons! {
                DispatchQueue.main.async(execute: {
                    button.dehighlightBorder()
                })
            }
        }
    }
    
    func didStartPlayingNotes(_ notes: [NoteOctave]) {
        if (playing) {
            for note in notes {
                let startedButtons = topPianoView()?.highlightedNoteButtons.filter({$0.noteOctave! == note})
                for button in startedButtons! {
                    DispatchQueue.main.async(execute: {
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
        if (topViewController is IdentifyViewController) {
            return (topViewController as! IdentifyViewController).pianoView
        }
        return nil
    }
}
