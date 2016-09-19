//
//  SettingsViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/31/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, PianoNavigationProtocol {
    var menuBarButton: UIBarButtonItem?
    var pianoNavigationViewController: PianoNavigationViewController?
    
    @IBOutlet weak var TriadLabel: UILabel!
    @IBOutlet weak var NoteLetterLabel: UILabel!
    @IBOutlet weak var NoteNumberLabel: UILabel!
    @IBOutlet weak var TriadSwitch: UISwitch!
    @IBOutlet weak var NoteLetterSwitch: UISwitch!
    @IBOutlet weak var NoteNumberSwitch: UISwitch!
    
    @IBAction func NoteNumberSwitched(_ sender: AnyObject) {
        Preferences.labelNoteNumber = NoteNumberSwitch.isOn
    }
    
    @IBAction func NoteLetterSwitched(_ sender: AnyObject) {
        Preferences.labelNoteLetter = NoteLetterSwitch.isOn
    }
    
    @IBAction func HighlightTriadsSwitched(_ sender: AnyObject) {
        Preferences.highlightTriads = TriadSwitch.isOn
    }
    
    override func viewDidLoad() {
        navigationController!.interactivePopGestureRecognizer?.isEnabled = false

        view.backgroundColor = Colors.chordTableBackgroundColor
        NoteLetterSwitch.onTintColor = Colors.settingsSwitchTintColor
        NoteNumberSwitch.onTintColor = Colors.settingsSwitchTintColor
        TriadSwitch.onTintColor = Colors.settingsSwitchTintColor
        
        TriadLabel.font = Fonts.chordListItem
        NoteNumberLabel.font = Fonts.chordListItem
        NoteLetterLabel.font = Fonts.chordListItem
        
        NoteLetterSwitch.isOn = Preferences.labelNoteLetter
        NoteNumberSwitch.isOn = Preferences.labelNoteNumber
        TriadSwitch.isOn = Preferences.highlightTriads
    }

    func updateNavigationItem() {
        pianoNavigationViewController = navigationController as? PianoNavigationViewController
        pianoNavigationViewController?.customNavigationItem.titleView = nil
        pianoNavigationViewController?.customNavigationItem.title = "Settings"
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = nil
        menuBarButton = UIBarButtonItem(customView: pianoNavigationViewController!.menuButton)
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = menuBarButton
    }
}
