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
    var chordSelectorViewController: ChordSelectorViewController?
    var scaleSelectorViewController: ScaleSelectorViewController?
    var settingsViewController: SettingsViewController?
    let audioEngine = AudioEngine()
    var isPlaying = false
    var interruptPlaying = false // For stopping progressions
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        
        pushViewController(pianoViewController, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create VCs
        slideMenuViewController.pianoNavigationController = self
        
        let chordSelectorStoryboard = UIStoryboard(name: "ChordSelectorStoryboard", bundle: nil)
        chordSelectorViewController = chordSelectorStoryboard.instantiateViewController(withIdentifier: "chordSelectorViewController") as? ChordSelectorViewController
        
        let scaleSelectorStoryboard = UIStoryboard(name: "ScaleSelectorStoryboard", bundle: nil)
        scaleSelectorViewController = scaleSelectorStoryboard.instantiateViewController(withIdentifier: "scaleSelectorViewController") as? ScaleSelectorViewController

        let settingsStoryboard = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
        settingsViewController = settingsStoryboard.instantiateViewController(withIdentifier: "settingsStoryboard") as? SettingsViewController
        
        // Xcode 9 nav bar struggles https://stackoverflow.com/questions/46138245/how-to-change-navigationbar-height-in-ios-11/46138389
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = Colors.toolBarBackground
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        
        UINavigationBar.appearance().titleTextAttributes = ["Font": Fonts.toolbarTitle!]
        UINavigationBar.appearance()
        navigationController?.navigationBar.isHidden = true
        customNavigationBar.isTranslucent = false
        customNavigationBar.barTintColor = Colors.toolBarBackground
        customNavigationBar.backgroundColor = Colors.toolBarBackground
        customNavigationBar.shadowImage = UIImage()
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
        
        let newSessionButton = sessionsViewController.newSessionButton
        newSessionButton.setTitle("\u{f24a}", for: UIControlState.normal)
        newSessionButton.titleLabel?.font = Fonts.newSessionButton
        newSessionButton.sizeToFit()
        newSessionButton.setTitleColor(Colors.normalRightBarButton, for: .normal)
        newSessionButton.setTitleColor(Colors.pressedRightBarButton, for: .highlighted)
        newSessionButton.addTarget(self, action: #selector(newSession), for: .touchUpInside)
        
        let editSessionButton = sessionsViewController.editSessionButton
        editSessionButton.setTitle("\u{f044}", for: UIControlState.normal)
        editSessionButton.titleLabel?.font = Fonts.editSessionButton
        editSessionButton.sizeToFit()
        editSessionButton.setTitleColor(Colors.normalRightBarButton, for: .normal)
        editSessionButton.setTitleColor(Colors.pressedRightBarButton, for: .highlighted)
        editSessionButton.addTarget(self, action: #selector(editSessions), for: .touchUpInside)
        
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

    func newSession() {
        sessionsViewController.newSession()
    }
    
    func editSessions() {
        sessionsViewController.editSessions()
    }
    
    func addChordToProgression() {
        let chord = chordSelectorViewController!.chord
        Globals.session?.chords.append(chord)
        chordTableViewController.tableView!.reloadData()
        popViewController(animated: false)
        pushViewController(chordTableViewController, animated: false)
        SessionManager.saveSessions()
    }
    
    func cancelChordToProgression() {
        popViewController(animated: false)
        pushViewController(chordTableViewController, animated: false)
    }

    func addScaleToProgression() {
        let scale = scaleSelectorViewController!.scale!
        Globals.session?.scales.append(scale)
        scaleTableViewController.tableView!.reloadData()
        popViewController(animated: false)
        pushViewController(scaleTableViewController, animated: false)
        SessionManager.saveSessions()
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
            PianoViewHightlighter.clearBorderHighlighting(pianoView: pianoView)
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
            let pianoView = pianoViewController.pianoView
            PianoViewHightlighter.clearBorderHighlighting(pianoView: pianoView)
            DispatchQueue.main.async(execute: {
                if (!Preferences.autoPlayProgression || self.interruptPlaying) {
                    self.pianoViewController.playButton.setTitle("\u{f144}", for: UIControlState())
                }
            })
        }
    }
    
    func togglePlay() {
        if (!isPlaying) {
            interruptPlaying = false
            startPlaying()
        } else {
            interruptPlaying = true
            stopPlaying()
        }
    }
    
    func completedProgression() {
        let pianoView = pianoViewController.pianoView
        PianoViewHightlighter.clearBorderHighlighting(pianoView: pianoView)
        DispatchQueue.main.async(execute: {
            self.pianoViewController.playButton.setTitle("\u{f144}", for: UIControlState())
        })
    }
    
    func didFinishPlaying() {
        stopPlaying()
        
        if (Preferences.autoPlayProgression && !interruptPlaying) {
            self.pianoViewController.continueProgression()
        }
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
