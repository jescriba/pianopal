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
    
    override func viewDidLoad() {
        view.backgroundColor = Colors.chordTableBackgroundColor
        NoteLetterSwitch.onTintColor = Colors.settingsSwitchTintColor
        NoteNumberSwitch.onTintColor = Colors.settingsSwitchTintColor
        TriadSwitch.onTintColor = Colors.settingsSwitchTintColor
        
        TriadLabel.font = Fonts.chordListItem
        NoteNumberLabel.font = Fonts.chordListItem
        NoteLetterLabel.font = Fonts.chordListItem
    }

    func updateNavigationItem() {
        pianoNavigationViewController = navigationController as? PianoNavigationViewController
        pianoNavigationViewController?.customNavigationItem.title = "Settings"
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = nil
        menuBarButton = UIBarButtonItem(customView: pianoNavigationViewController!.menuButton)
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = menuBarButton
    }
}
