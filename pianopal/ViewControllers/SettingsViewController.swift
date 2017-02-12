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
    @IBOutlet weak var AutoPlayProgressionSwitch: UISwitch!
    
    @IBAction func NoteNumberSwitched(_ sender: AnyObject) {
        Preferences.labelNoteNumber = NoteNumberSwitch.isOn
    }
    
    @IBAction func NoteLetterSwitched(_ sender: AnyObject) {
        Preferences.labelNoteLetter = NoteLetterSwitch.isOn
    }
    
    @IBAction func HighlightTriadsSwitched(_ sender: AnyObject) {
        Preferences.highlightTriads = TriadSwitch.isOn
    }
    
    @IBAction func AutoPlayProgressionSwitched(_ sender: Any) {
        Preferences.autoPlayProgression = AutoPlayProgressionSwitch.isOn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.interactivePopGestureRecognizer?.isEnabled = false

        view.backgroundColor = Colors.tableBackground
        NoteLetterSwitch.onTintColor = Colors.settingsSwitchTint
        NoteNumberSwitch.onTintColor = Colors.settingsSwitchTint
        TriadSwitch.onTintColor = Colors.settingsSwitchTint
        AutoPlayProgressionSwitch.onTintColor = Colors.settingsSwitchTint
        NoteLetterSwitch.isOn = Preferences.labelNoteLetter
        NoteNumberSwitch.isOn = Preferences.labelNoteNumber
        TriadSwitch.isOn = Preferences.highlightTriads
        AutoPlayProgressionSwitch.isOn = Preferences.autoPlayProgression
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateNavigationItem()
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
