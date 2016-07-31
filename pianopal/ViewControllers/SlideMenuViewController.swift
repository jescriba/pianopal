//
//  SlideMenuViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/31/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class SlideMenuViewController: UITableViewController {
    let offset: CGFloat = 200
    let navigationItems = ["Chord Progression", "Scale", "Scale Progression", "Identify", "Settings"]
    var expanded = false
    var pianoNavigationController: PianoNavigationViewController?
    
    override func viewDidLoad() {
        tableView!.tableFooterView = UIView(frame: CGRectZero)
        tableView!.backgroundColor = Colors.slideMenuBackgroundColor
        tableView.dataSource = self
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewCell =  UITableViewCell(style: .Default, reuseIdentifier: "navigationPage")
        tableViewCell.textLabel!.text = navigationItems[indexPath.row]
        tableViewCell.textLabel!.font = Fonts.chordListItem
        tableViewCell.backgroundColor = Colors.slideMenuBackgroundColor
        return tableViewCell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return navigationItems.count
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
