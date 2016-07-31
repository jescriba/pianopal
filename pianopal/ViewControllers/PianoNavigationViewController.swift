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
    let addChordButton = UIButton(frame: Dimensions.rightBarButtonRect)
    let cancelChordButton = UIButton(frame: Dimensions.menuButtonRect)
    let saveChordButton = UIButton(frame: Dimensions.rightBarButtonRect)
    let addScaleButton = UIButton(frame: Dimensions.rightBarButtonRect)
    let cancelScaleButton = UIButton(frame: Dimensions.menuButtonRect)
    let saveScaleButton = UIButton(frame: Dimensions.rightBarButtonRect)
    var chordTableViewController: ChordTableViewController?
    var chordSelectorViewController: ChordSelectorViewController?
    var chordViewController: ChordViewController?
    var identifyViewController: IdentifyViewController?
    var scaleTableViewController: ScaleTableViewController?
    var scaleSelectorViewController: ScaleSelectorViewController?
    var scaleViewController: ScaleViewController?
    var slideMenuViewController: SlideMenuViewController?
    
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

        
        // Create Controllers
        chordTableViewController = ChordTableViewController()
        scaleTableViewController = ScaleTableViewController()
        scaleViewController = ScaleViewController()
        identifyViewController = IdentifyViewController()
        slideMenuViewController = SlideMenuViewController()
        slideMenuViewController!.pianoNavigationController = self
    }
    
    func goToMenu() {
        toggleSlideMenuPanel()
//        switch topViewController {
//        case _ as ChordViewController:
//            customNavigationItem.titleView = nil
//            popViewControllerAnimated(false)
//            pushViewController(chordTableViewController!, animated: false)
//            chordTableViewController?.updateNavigationItem()
//        case _ as ScaleViewController:
//            customNavigationItem.titleView = nil
//            popViewControllerAnimated(false)
//            pushViewController(scaleTableViewController!, animated: false)
//            scaleTableViewController?.updateNavigationItem()
//            break;
//        case _ as IdentifyViewController:
//            break;
//        case _ as ChordTableViewController:
//            popToRootViewControllerAnimated(false)
//            chordViewController?.chords = (chordTableViewController?.chords)!
//            chordViewController?.updateNavigationItem()
//            chordViewController?.highlightChord(nil)
//        case _ as ScaleTableViewController:
//            popViewControllerAnimated(false)
//            pushViewController(scaleViewController!, animated: false)
//            scaleViewController?.scales = (scaleTableViewController?.scales)!
//            scaleViewController?.updateNavigationItem()
//            scaleViewController?.highlightScale(nil)
//        default:
//            break
//        }
    }
    
    func toggleSlideMenuPanel() {
        if (!slideMenuViewController!.expanded) {
            parentViewController!.addChildViewController(slideMenuViewController!)
            parentViewController!.view.insertSubview((slideMenuViewController?.view)!, atIndex: 0)
            slideMenuViewController?.didMoveToParentViewController(self)
        }
        slideMenuViewController?.togglePanel()
    }
    
    func changeMode() {
        switch topViewController {
        case _ as ChordViewController:
            customNavigationItem.titleView = nil
            popViewControllerAnimated(false)
            pushViewController(scaleViewController!, animated: false)
            scaleViewController?.updateNavigationItem()
        case _ as ScaleViewController:
            popViewControllerAnimated(false)
            pushViewController(identifyViewController!, animated: false)
            identifyViewController?.updateNavigationItem()
        case _ as IdentifyViewController:
            popViewControllerAnimated(false)
            popToRootViewControllerAnimated(false)
            chordViewController?.updateNavigationItem()
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
    
    func goToScaleSelector() {
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
        chordTableViewController?.tableView.reloadData()
        popViewControllerAnimated(false)
        pushViewController(chordTableViewController!, animated: false)
        chordTableViewController?.updateNavigationItem()
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
        scaleTableViewController?.tableView.reloadData()
        popViewControllerAnimated(false)
        pushViewController(scaleTableViewController!, animated: false)
        scaleTableViewController?.updateNavigationItem()
    }
    
    func cancelScaleToProgression() {
        popViewControllerAnimated(false)
        pushViewController(scaleTableViewController!, animated: false)
        scaleTableViewController?.updateNavigationItem()
    }
}
