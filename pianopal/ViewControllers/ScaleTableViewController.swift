//
//  ScaleTableViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/24/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class ScaleTableViewController: UITableViewController, PianoNavigationProtocol {
    var pianoNavigationViewController: PianoNavigationViewController?
    var scales = [Scale]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(ScaleTableViewCell.self, forCellReuseIdentifier: "ScaleTableViewCell")
        
        updateNavigationItem()
        tableView.separatorColor = Colors.chordTableSeparatorColor
        tableView.rowHeight = 90
        tableView.backgroundColor = Colors.chordTableBackgroundColor
        tableView.allowsSelectionDuringEditing = true
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ScaleTableViewCell", forIndexPath: indexPath) as! ScaleTableViewCell
        cell.scaleLabel!.text = scales[indexPath.row].simpleDescription()
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scales.count
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            scales.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let scale = scales[sourceIndexPath.row]
        scales.removeAtIndex(sourceIndexPath.row)
        scales.insert(scale, atIndex: destinationIndexPath.row)
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        editing = !editing
    }


    func updateNavigationItem() {
        pianoNavigationViewController = navigationController as? PianoNavigationViewController
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = nil
        let plusButton = pianoNavigationViewController?.addScaleButton
        plusButton!.setTitle("\u{f196}", forState: UIControlState.Normal)
        plusButton!.setTitleColor(Colors.normalRightBarButtonColor, forState: UIControlState.Normal)
        plusButton!.setTitleColor(Colors.pressedRightBarButtonColor, forState: UIControlState.Highlighted)
        plusButton!.titleLabel!.font = Fonts.changeModeButton
        let plusBarButtonItem = UIBarButtonItem(customView: plusButton!)
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = plusBarButtonItem
        pianoNavigationViewController?.customNavigationItem.title = "Scale Progression"
        let menuButton = pianoNavigationViewController?.menuButton
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton!)
    }
}
