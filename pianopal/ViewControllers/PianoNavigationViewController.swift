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
    let pianoViewController = PianoViewController()
    let chordTableViewController = ChordTableViewController()
    let scaleTableViewController =  ScaleTableViewController()
    let slideMenuViewController = SlideMenuViewController()
    let settingsViewController = SettingsViewController()
    let sessionsViewController = SessionsViewController()
    let audioEngine = AudioEngine()
    var chordSelectorViewController: ChordSelectorViewController?
    var scaleSelectorViewController: ScaleSelectorViewController?
    var isPlaying = false
//    let cancelChordButton = UIButton(frame: Dimensions.menuButtonRect)
//    let saveChordButton = UIButton(frame: Dimensions.rightBarButtonRect)
//    let addScaleButton = UIButton(frame: Dimensions.rightBarButtonRect)
//    let cancelScaleButton = UIButton(frame: Dimensions.menuButtonRect)
//    let saveScaleButton = UIButton(frame: Dimensions.rightBarButtonRect)

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideMenuViewController.pianoNavigationController = self
        
        
        //UINavigationBar.appearance().attri

//        UINavigationBar.appearance().titleTextAttributes = ["Font": Fonts.changeToolbarAction!]
//        navigationController?.navigationBar.isHidden = true
//        customNavigationBar.layer.shadowOpacity = 0.5
//        customNavigationBar.isTranslucent = false
//        customNavigationBar.barTintColor = Colors.toolBarBackground
//        customNavigationBar.setItems([customNavigationItem], animated: false)
//        view.addSubview(customNavigationBar)
//        
//        menuButton.setTitle("\u{f0c9}", for: UIControlState())
//        menuButton.titleLabel!.font = Fonts.menuButton
//        menuButton.setTitleColor(Colors.normalMenuButtonColor, for: UIControlState())
//        menuButton.setTitleColor(Colors.presssedMenuButtonColor, for: UIControlState.highlighted)
//        menuButton.addTarget(self, action: #selector(toggleSlideMenuPanel), for: UIControlEvents.touchUpInside)
//        
//        addChordButton.addTarget(self, action: #selector(goToChordSelector), for: UIControlEvents.touchUpInside)
//        cancelChordButton.setTitle("Cancel", for: UIControlState())
//        cancelChordButton.sizeToFit()
//        cancelChordButton.setTitleColor(Colors.normalRightBarButtonColor, for: UIControlState())
//        cancelChordButton.setTitleColor(Colors.pressedRightBarButtonColor, for: UIControlState.highlighted)
//        cancelChordButton.addTarget(self, action: #selector(cancelChordToProgression), for: UIControlEvents.touchUpInside)
//        saveChordButton.setTitle("Save", for: UIControlState())
//        saveChordButton.sizeToFit()
//        saveChordButton.setTitleColor(Colors.normalRightBarButtonColor, for: UIControlState())
//        saveChordButton.setTitleColor(Colors.pressedRightBarButtonColor, for: UIControlState.highlighted)
//        saveChordButton.addTarget(self, action: #selector(addChordToProgression), for: UIControlEvents.touchUpInside)
//        
//        addScaleButton.addTarget(self, action: #selector(goToScaleSelector), for: UIControlEvents.touchUpInside)
//        cancelScaleButton.setTitle("Cancel", for: UIControlState())
//        cancelScaleButton.sizeToFit()
//        cancelScaleButton.setTitleColor(Colors.normalRightBarButtonColor, for: UIControlState())
//        cancelScaleButton.setTitleColor(Colors.pressedRightBarButtonColor, for: UIControlState.highlighted)
//        cancelScaleButton.addTarget(self, action: #selector(cancelScaleToProgression), for: UIControlEvents.touchUpInside)
//        saveScaleButton.setTitle("Save", for: UIControlState())
//        saveScaleButton.sizeToFit()
//        saveScaleButton.setTitleColor(Colors.normalRightBarButtonColor, for: UIControlState())
//        saveScaleButton.setTitleColor(Colors.pressedRightBarButtonColor, for: UIControlState.highlighted)
//        saveScaleButton.addTarget(self, action: #selector(addScaleToProgression), for: UIControlEvents.touchUpInside)
//        
//        playButton.setTitle("\u{f144}", for: UIControlState())
//        playButton.titleLabel!.font = Fonts.playButton
//        playButton.sizeToFit()
//        playButton.setTitleColor(Colors.normalPlayButtonColor, for: UIControlState())
//        playButton.setTitleColor(Colors.pressedPlayButtonColor, for: UIControlState())
//        playButton.addTarget(self, action: #selector(togglePlay), for: UIControlEvents.touchUpInside)
//        
//        saveSessionButton.setTitle("Save", for: UIControlState.normal)
//        saveSessionButton.sizeToFit()
//        saveSessionButton.setTitleColor(Colors.normalRightBarButtonColor, for: UIControlState.normal)
//        saveSessionButton.setTitleColor(Colors.pressedRightBarButtonColor, for: UIControlState.highlighted)
//        saveSessionButton.addTarget(self, action: #selector(saveSession), for: UIControlEvents.touchUpInside)
//        
//        // Create Controllers
//        chordTableViewController = ChordTableViewController()
//        scaleTableViewController = ScaleTableViewController()
//        scaleViewController = ScaleViewController()
//        identifyViewController = IdentifyViewController()
//        sessionsViewController = SessionsViewController()
//        slideMenuViewController = SlideMenuViewController()
//        slideMenuViewController!.pianoNavigationController = self
//        
//        let storyboard = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
//        settingsViewController = storyboard.instantiateViewController(withIdentifier: "settingsStoryboard") as? SettingsViewController
//        
//        // Load Previous Session
//        let chords = Session.loadChords()
//        let scales = Session.loadScales()
//        if chords != nil {
//            chordTableViewController?.chords = chords!
//            chordViewController?.chords = chords!
//        }
//        if scales != nil {
//            scaleTableViewController?.scales = scales!
//            scaleViewController?.scales = scales!
//        }
//        
//        audioEngine = AudioEngine()
//        audioEngine?.delegate = self
    }
    
    func addSlideMenuPanel() {
        if !parent!.childViewControllers.contains(slideMenuViewController) {
            parent!.addChildViewController(slideMenuViewController)
            slideMenuViewController.didMove(toParentViewController: self)
        }
        parent!.view.insertSubview((slideMenuViewController.view)!, at: 0)
    }
    
    func removeSlideMenuPanel() {
        if parent!.childViewControllers.contains(slideMenuViewController) {
            slideMenuViewController.removeFromParentViewController()
            slideMenuViewController.didMove(toParentViewController: self)
        }
    }
    
    func toggleSlideMenuPanel() {
        addSlideMenuPanel()
        slideMenuViewController.togglePanel()
    }
    
    func goToChordTableView() {
        customNavigationItem.titleView = nil
        popViewController(animated: false)
        pushViewController(chordTableViewController, animated: true)
        chordTableViewController.updateNavigationItem()
    }
    
    func goToScaleTableView() {
        customNavigationItem.titleView = nil
        popViewController(animated: false)
        pushViewController(scaleTableViewController, animated: true)
        scaleTableViewController.updateNavigationItem()
    }

    func goToSettingsView() {
        popViewController(animated: false)
        pushViewController(settingsViewController, animated: true)
        settingsViewController.updateNavigationItem()
    }
    
    func goToSessionsView() {
        popViewController(animated: false)
        pushViewController(sessionsViewController, animated: true)
        sessionsViewController.updateNavigationItem()
    }

    func goToChordSelector() {
        removeSlideMenuPanel()
        popViewController(animated: false)
        if (chordSelectorViewController == nil) {
            let storyboard = UIStoryboard(name: "ChordSelectorStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "chordSelectorStoryboard")
            chordSelectorViewController = vc as? ChordSelectorViewController
        }
        pushViewController(chordSelectorViewController!, animated: true)
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
//
//    func saveSession() {
//        let chords = chordViewController?.chords
//        let scales = scaleViewController?.scales
//        if (chords?.count ?? 0 > 0 || scales?.count ?? 0 > 0) {
//            let saveSessionVC = SaveSessionViewController()
//            saveSessionVC.modalPresentationStyle = UIModalPresentationStyle.popover
//            present(saveSessionVC, animated: true, completion: nil)
//            
//            let presentationController = saveSessionVC.popoverPresentationController
//            presentationController?.canOverlapSourceViewRect = false
//            presentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
//            presentationController?.sourceView = saveSessionVC.saveBoxView
//            presentationController?.sourceRect = saveSessionVC.saveBoxView!.frame
//        }
//    }
//    
//    func addChordToProgression() {
//        let rootNote = chordSelectorViewController?.rootNotePickerView.selectedRow(inComponent: 0)
//        let chordType = chordSelectorViewController?.chordTypePickerView.selectedRow(inComponent: 0)
//        let chord = ChordGenerator.generateChord(Note(rawValue: rootNote!)!, chordType: ChordType(rawValue: chordType!)!)
//        chordTableViewController?.chords.append(chord)
//        chordTableViewController?.tableView!.reloadData()
//        popViewController(animated: false)
//        pushViewController(chordTableViewController!, animated: false)
//        chordTableViewController?.updateNavigationItem()
//        Session.save(chords: chordTableViewController?.chords)
//    }
//    
//    func cancelChordToProgression() {
//        popViewController(animated: false)
//        pushViewController(chordTableViewController!, animated: false)
//        chordTableViewController?.updateNavigationItem()
//    }
//    
//    func addScaleToProgression() {
//        let rootNote = scaleSelectorViewController?.rootNotePickerView.selectedRow(inComponent: 0)
//        let scaleType = scaleSelectorViewController?.scaleTypePickerView.selectedRow(inComponent: 0)
//        let scale = ScaleGenerator.generateScale(Note(rawValue: rootNote!)!, scaleType: ScaleType(rawValue: scaleType!)!)
//        scaleTableViewController?.scales.append(scale)
//        scaleTableViewController?.tableView!.reloadData()
//        popViewController(animated: false)
//        pushViewController(scaleTableViewController!, animated: false)
//        scaleTableViewController?.updateNavigationItem()
//        Session.save(scaleTableViewController?.scales)
//    }
//    
//    func cancelScaleToProgression() {
//        popViewController(animated: false)
//        pushViewController(scaleTableViewController!, animated: false)
//        scaleTableViewController?.updateNavigationItem()
//    }
//    
    func startPlaying() {
        if (!isPlaying) {
            isPlaying = true
            pianoViewController.playButton.setTitle("\u{f28d}", for: UIControlState())
            let pianoView = pianoViewController.pianoView
            let notes = NoteOctaveDetector.determineNoteOctavesOnScreen(pianoView)
            if (pianoViewController.pianoViewMode == PianoViewMode.scale) {
                audioEngine.play(notes, isScale: true)
            } else {
                audioEngine.play(notes)
            }
        }
    }
    
    func stopPlaying() {
        if (isPlaying) {
            isPlaying = false
            audioEngine.stop()
            let highlightedNoteButtons = pianoViewController.highlightedNoteButtons
            for button in highlightedNoteButtons {
                DispatchQueue.main.async(execute: {
                    button.dehighlightBorder()
                })
            }
            DispatchQueue.main.async(execute: {
                self.pianoViewController.playButton.setTitle("\u{f144}", for: UIControlState())
            })
        }
    }
    
    func togglePlay() {
        if (!isPlaying) {
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
            let finishedButtons = pianoViewController.highlightedNoteButtons.filter({$0.noteOctave! == note})
            for button in finishedButtons {
                DispatchQueue.main.async(execute: {
                    button.dehighlightBorder()
                })
            }
        }
    }
    
    func didStartPlayingNotes(_ notes: [NoteOctave]) {
        if (isPlaying) {
            for note in notes {
                let startedButtons = pianoViewController.highlightedNoteButtons.filter({$0.noteOctave! == note})
                for button in startedButtons {
                    DispatchQueue.main.async(execute: {
                        button.highlightBorder()
                    })
                }
            }
        }
    }
}
