//
//  PianoNavigationViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/23/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class PianoNavigationViewController: UINavigationController, UIPopoverPresentationControllerDelegate, AudioEngineDelegate {
    
    let customNavigationBar = UINavigationBar(frame: Dimensions.toolbarRect)
    let customNavigationItem = UINavigationItem(title: "Piano")
    let menuButton = UIButton(frame: Dimensions.menuButtonRect)
    let pianoViewController = PianoViewController()
    let slideMenuViewController = SlideMenuViewController()
    let chordTableViewController = ChordTableViewController()
    let scaleTableViewController =  ScaleTableViewController()
    let sessionsViewController = SessionsViewController()
    let audioEngine = AudioEngine()
    var chordSelectorViewController: ChordSelectorViewController?
    var scaleSelectorViewController: ScaleSelectorViewController?
    var settingsViewController: SettingsViewController?
    var isPlaying = false
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        
        pushViewController(pianoViewController, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create VCs
        slideMenuViewController.pianoNavigationController = self
        
        let chordSelectorStoryboard = UIStoryboard(name: "ChordSelectorStoryboard", bundle: nil)
        chordSelectorViewController = chordSelectorStoryboard.instantiateViewController(withIdentifier: "chordSelectorStoryboard") as? ChordSelectorViewController
        
        let scaleSelectorStoryboard = UIStoryboard(name: "ScaleSelectorStoryboard", bundle: nil)
        scaleSelectorViewController = scaleSelectorStoryboard.instantiateViewController(withIdentifier: "scaleSelectorStoryboard") as? ScaleSelectorViewController

        let settingsStoryboard = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
        settingsViewController = settingsStoryboard.instantiateViewController(withIdentifier: "settingsStoryboard") as? SettingsViewController
        
        UINavigationBar.appearance().titleTextAttributes = ["Font": Fonts.toolbarTitle!]
        navigationController?.navigationBar.isHidden = true
        customNavigationBar.layer.shadowOpacity = 0.5
        customNavigationBar.isTranslucent = false
        customNavigationBar.barTintColor = Colors.toolBarBackground
        customNavigationBar.setItems([customNavigationItem], animated: false)
        view.addSubview(customNavigationBar)

        menuButton.setTitle("\u{f0c9}", for: .normal)
        menuButton.titleLabel!.font = Fonts.menuButton
        menuButton.setTitleColor(Colors.normalMenuButton, for: .normal)
        menuButton.setTitleColor(Colors.presssedMenuButton, for: .highlighted)
        menuButton.addTarget(self, action: #selector(toggleSlideMenuPanel), for: .touchUpInside)

        let addChordButton = chordTableViewController.plusButton
        let cancelChordButton = chordSelectorViewController!.cancelChordButton
        let saveChordButton = chordSelectorViewController!.saveChordButton
        addChordButton.addTarget(self, action: #selector(goToChordSelector), for: .touchUpInside)
        cancelChordButton.titleLabel!.font = Fonts.cancelButton
        cancelChordButton.setTitle("\u{f00d}", for: .normal)
        cancelChordButton.sizeToFit()
        cancelChordButton.setTitleColor(Colors.normalRightBarButton, for: .normal)
        cancelChordButton.setTitleColor(Colors.pressedRightBarButton, for: .highlighted)
        cancelChordButton.addTarget(self, action: #selector(cancelChordToProgression), for: .touchUpInside)
        saveChordButton.titleLabel!.font = Fonts.saveButton
        saveChordButton.setTitle("\u{f0c7}", for: .normal)
        saveChordButton.sizeToFit()
        saveChordButton.setTitleColor(Colors.normalRightBarButton, for: .normal)
        saveChordButton.setTitleColor(Colors.pressedRightBarButton, for: .highlighted)
        saveChordButton.addTarget(self, action: #selector(addChordToProgression), for: .touchUpInside)

        let addScaleButton = scaleTableViewController.plusButton
        let cancelScaleButton = scaleSelectorViewController!.cancelScaleButton
        let saveScaleButton = scaleSelectorViewController!.saveScaleButton
        addScaleButton.addTarget(self, action: #selector(goToScaleSelector), for: .touchUpInside)
        cancelScaleButton.titleLabel!.font = Fonts.cancelButton
        cancelScaleButton.setTitle("\u{f00d}", for: .normal)
        cancelScaleButton.sizeToFit()
        cancelScaleButton.setTitleColor(Colors.normalRightBarButton, for: .normal)
        cancelScaleButton.setTitleColor(Colors.pressedRightBarButton, for: .highlighted)
        cancelScaleButton.addTarget(self, action: #selector(cancelScaleToProgression), for: .touchUpInside)
        saveScaleButton.titleLabel!.font = Fonts.saveButton
        saveScaleButton.setTitle("\u{f0c7}", for: UIControlState())
        saveScaleButton.sizeToFit()
        saveScaleButton.setTitleColor(Colors.normalRightBarButton, for: .normal)
        saveScaleButton.setTitleColor(Colors.pressedRightBarButton, for: .highlighted)
        saveScaleButton.addTarget(self, action: #selector(addScaleToProgression), for: .touchUpInside)

        let playButton = pianoViewController.playButton
        playButton.setTitle("\u{f144}", for: .normal)
        playButton.titleLabel!.font = Fonts.playButton
        playButton.sizeToFit()
        playButton.setTitleColor(Colors.normalPlayButton, for: .normal)
        playButton.setTitleColor(Colors.pressedPlayButton, for: .highlighted)
        playButton.addTarget(self, action: #selector(togglePlay), for: .touchUpInside)
        
        let sessionRightButton = sessionsViewController.sessionRightButton
        sessionRightButton.setTitle("New", for: UIControlState.normal)
        sessionRightButton.sizeToFit()
        sessionRightButton.setTitleColor(Colors.normalRightBarButton, for: .normal)
        sessionRightButton.setTitleColor(Colors.pressedRightBarButton, for: .highlighted)
        sessionRightButton.addTarget(self, action: #selector(sessionRightButtonPressed), for: .touchUpInside)
        
        audioEngine.delegate = self
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
    
    func goToPianoView() {
        customNavigationItem.titleView = nil
        popToRootViewController(animated: false)
    }
    
    func goToChordTableView() {
        customNavigationItem.titleView = nil
        popViewController(animated: false)
        pushViewController(chordTableViewController, animated: false)
        chordTableViewController.updateNavigationItem()
    }
    
    func goToScaleTableView() {
        customNavigationItem.titleView = nil
        popViewController(animated: false)
        pushViewController(scaleTableViewController, animated: false)
        scaleTableViewController.updateNavigationItem()
    }

    func goToSettingsView() {
        popViewController(animated: false)
        pushViewController(settingsViewController!, animated: false)
        settingsViewController!.updateNavigationItem()
    }
    
    func goToSessionsView() {
        popViewController(animated: false)
        pushViewController(sessionsViewController, animated: false)
        sessionsViewController.updateNavigationItem()
    }

    func goToChordSelector() {
        removeSlideMenuPanel()
        popViewController(animated: false)
        pushViewController(chordSelectorViewController!, animated: false)
        chordSelectorViewController?.updateNavigationItem()
    }

    func goToScaleSelector() {
        removeSlideMenuPanel()
        popViewController(animated: false)
        pushViewController(scaleSelectorViewController!, animated: false)
        scaleSelectorViewController?.updateNavigationItem()
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController!) -> UIModalPresentationStyle {
        return .popover
    }

    func sessionRightButtonPressed() {
        sessionsViewController.sessionRightButtonPressed()
    }
    
    func addChordToProgression() {
        let rootNote = chordSelectorViewController?.rootNotePickerView.selectedRow(inComponent: 0)
        let chordType = chordSelectorViewController?.chordTypePickerView.selectedRow(inComponent: 0)
        let chord = ChordGenerator.generateChord(Note(rawValue: rootNote!)!, chordType: ChordType(rawValue: chordType!)!)
        Globals.session?.chords.append(chord)
        chordTableViewController.tableView!.reloadData()
        popViewController(animated: false)
        pushViewController(chordTableViewController, animated: false)
        SessionManager.saveSession(Globals.session)
    }
    
    func cancelChordToProgression() {
        popViewController(animated: false)
        pushViewController(chordTableViewController, animated: false)
    }

    func addScaleToProgression() {
        let rootNote = scaleSelectorViewController?.rootNotePickerView.selectedRow(inComponent: 0)
        let scaleType = scaleSelectorViewController?.scaleTypePickerView.selectedRow(inComponent: 0)
        let scale = ScaleGenerator.generateScale(Note(rawValue: rootNote!)!, scaleType: ScaleType(rawValue: scaleType!)!)
        Globals.session?.scales.append(scale)
        scaleTableViewController.tableView!.reloadData()
        popViewController(animated: false)
        pushViewController(scaleTableViewController, animated: false)
        SessionManager.saveSession(Globals.session)
    }
    
    func cancelScaleToProgression() {
        popViewController(animated: false)
        pushViewController(scaleTableViewController, animated: false)
    }
    
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
