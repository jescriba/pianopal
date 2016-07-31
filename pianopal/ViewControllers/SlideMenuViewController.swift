//
//  SlideMenuViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/31/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

enum NavigationPage : Int {
    case ChordProgression, Chord, Scale, ScaleProgression, Identify, Settings
    
    func simpleDescription() -> String {
        if (self == NavigationPage.ChordProgression) {
            return "Chord Progression"
        } else if (self == NavigationPage.ScaleProgression) {
            return "Scale Progression"
        } else {
            return "\(self)"
        }
    }
}

class SlideMenuViewController: UITableViewController {
    let offset: CGFloat = 200
    let navigationItems = [NavigationPage.ChordProgression, NavigationPage.Chord, NavigationPage.Scale, NavigationPage.ScaleProgression, NavigationPage.Identify, NavigationPage.Settings]
    var expanded = false
    var pianoNavigationController: PianoNavigationViewController?
    
    override func viewDidLoad() {
        tableView!.tableFooterView = UIView(frame: CGRectZero)
        tableView!.backgroundColor = Colors.slideMenuBackgroundColor
        tableView.dataSource = self
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewCell =  UITableViewCell(style: .Default, reuseIdentifier: "navigationPage")
        tableViewCell.textLabel!.text = navigationItems[indexPath.row].simpleDescription()
        tableViewCell.textLabel!.font = Fonts.chordListItem
        tableViewCell.backgroundColor = Colors.slideMenuBackgroundColor
        return tableViewCell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return navigationItems.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch navigationItems[indexPath.row] {
            case .ChordProgression:
                pianoNavigationController!.goToChordTableView()
            case .ScaleProgression:
                pianoNavigationController!.goToScaleTableView()
            case .Chord:
                pianoNavigationController!.goToChordView()
            case .Scale:
                pianoNavigationController!.goToScaleView()
            case .Identify:
                pianoNavigationController!.goToIdentifyView()
            case .Settings:
                pianoNavigationController!.goToSettingsView()
        }
        pianoNavigationController!.toggleSlideMenuPanel()
    }
    
    func togglePanel() {
        if (expanded) {
            collapsePanel()
            expanded = false
        } else {
            expandPanel()
            expanded = true
        }
    }
    
    func expandPanel() {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
                self.pianoNavigationController!.view.layer.shadowOpacity = 0.8
                self.pianoNavigationController!.view.frame.origin.x = self.offset
            }, completion: nil)
    }
    
    func collapsePanel() {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.pianoNavigationController!.view.frame.origin.x = 0
            }, completion: { (Bool) in
                self.view.removeFromSuperview()
        })
    }
}
