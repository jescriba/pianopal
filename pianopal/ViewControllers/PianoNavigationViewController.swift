//
//  PianoNavigationViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/23/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class PianoNavigationViewController: UINavigationController {
    let customNavigationBar = UINavigationBar(frame: Dimensions.toolbarRect)
    let customNavigationItem = UINavigationItem(title: "Piano")
    let menuButton = UIButton(frame: Dimensions.menuButtonRect)
    let changeModeButton = UIButton(frame: Dimensions.changeModeButtonRect)
    let addChordButton = UIButton(frame: Dimensions.changeModeButtonRect)
    let cancelChordbutton = UIButton(frame: Dimensions.menuButtonRect)
    let saveChordButton = UIButton(frame: Dimensions.changeModeButtonRect)
    var chordTableViewController: ChordTableViewController?
    var chordSelectorViewController: ChordSelectorViewController?
    var chordViewController: ChordViewController?
    
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
        menuButton.addTarget(self, action: #selector(goToMenu), forControlEvents: UIControlEvents.TouchUpInside)
        
        changeModeButton.setTitle("\u{f105}", forState: UIControlState.Normal)
        changeModeButton.titleLabel!.font = Fonts.changeModeButton
        changeModeButton.setTitleColor(Colors.normalChangeModeColor, forState: UIControlState.Normal)
        changeModeButton.setTitleColor(Colors.pressedChangeModeColor, forState: UIControlState.Highlighted)
        changeModeButton.addTarget(self, action: #selector(changeMode), forControlEvents: UIControlEvents.TouchUpInside)
        
        addChordButton.addTarget(self, action: #selector(goToChordSelector), forControlEvents: UIControlEvents.TouchUpInside)
        cancelChordbutton.setTitle("Cancel", forState: UIControlState.Normal)
        cancelChordbutton.sizeToFit()
        cancelChordbutton.setTitleColor(Colors.normalChangeModeColor, forState: UIControlState.Normal)
        cancelChordbutton.setTitleColor(Colors.pressedChangeModeColor, forState: UIControlState.Highlighted)
        cancelChordbutton.addTarget(self, action: #selector(cancelChordToProgression), forControlEvents: UIControlEvents.TouchUpInside)
        saveChordButton.setTitle("Save", forState: UIControlState.Normal)
        saveChordButton.sizeToFit()
        saveChordButton.setTitleColor(Colors.normalChangeModeColor, forState: UIControlState.Normal)
        saveChordButton.setTitleColor(Colors.pressedChangeModeColor, forState: UIControlState.Highlighted)
        saveChordButton.addTarget(self, action: #selector(addChordToProgression), forControlEvents: UIControlEvents.TouchUpInside)
        
        // Create Controllers
        chordTableViewController = ChordTableViewController()
    }
    
    func goToMenu() {
        switch topViewController {
        case _ as ChordViewController:
            customNavigationItem.titleView = nil
            popViewControllerAnimated(false)
            pushViewController(chordTableViewController!, animated: false)
            chordTableViewController?.updateNavigationItem()
        case _ as ScaleViewController:
            break;
        case _ as IdentifyViewController:
            break;
        case _ as ChordTableViewController:
            popToRootViewControllerAnimated(false)
            chordViewController?.chords = (chordTableViewController?.chords)!
            chordViewController?.updateNavigationItem()
            chordViewController?.highlightChord()
        default:
            break
        }
    }
    
    func changeMode() {
        switch topViewController {
        case _ as ChordViewController:
            customNavigationItem.titleView = nil
            popViewControllerAnimated(false)
            pushViewController(ScaleViewController(), animated: false)
        case _ as ScaleViewController:
            popViewControllerAnimated(false)
            pushViewController(IdentifyViewController(), animated: false)
        case _ as IdentifyViewController:
            popViewControllerAnimated(false)
            pushViewController(ChordViewController(), animated: false)
        default:
            break
        }
    }
    
    func goToChordSelector() {
        popViewControllerAnimated(false)
        if (chordSelectorViewController == nil) {
            let storyboard = UIStoryboard(name: "ChordSelectorStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("chordSelectorStoryboard")
            chordSelectorViewController = vc as? ChordSelectorViewController
        }
        pushViewController(chordSelectorViewController!, animated: false)
        chordSelectorViewController?.updateNavigationItem()
    }
    
    func addChordToProgression() {
        let rootNote = chordSelectorViewController?.rootNotePickerView.selectedRowInComponent(0)
        let chordType = chordSelectorViewController?.chordTypePickerView.selectedRowInComponent(0)
        let chord = ChordGenerator.generateChord(Note(rawValue: rootNote!)!, chordType: ChordType(rawValue: chordType!)!)
        chordTableViewController?.chords.append(chord)
        chordTableViewController?.tableView.reloadData()
        popViewControllerAnimated(false)
        pushViewController(chordTableViewController!, animated: false)
        chordTableViewController?.updateNavigationItem()
    }
    
    func cancelChordToProgression() {
        popViewControllerAnimated(false)
        pushViewController(chordTableViewController!, animated: false)
        chordTableViewController?.updateNavigationItem()
        customNavigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
    }
}
