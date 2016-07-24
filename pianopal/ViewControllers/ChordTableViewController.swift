//
//  ChordProgressionMenuViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/17/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class ChordTableViewController: UITableViewController, PianoNavigationProtocol {
    var pianoNavigationViewController: PianoNavigationViewController?
    var chords = [Chord]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(ChordTableViewCell.self, forCellReuseIdentifier: "ChordTableViewCell")
        
        updateNavigationItem()
        tableView.separatorColor = Colors.chordTableSeparatorColor
        tableView.rowHeight = 90
        tableView.backgroundColor = Colors.chordTableBackgroundColor
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChordTableViewCell", forIndexPath: indexPath) as! ChordTableViewCell
        cell.chordLabel!.text = chords[indexPath.row].simpleDescription()
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chords.count
    }
    
    func updateNavigationItem() {
        pianoNavigationViewController = navigationController as? PianoNavigationViewController
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = nil
        let plusButton = pianoNavigationViewController?.addChordButton
        plusButton!.setTitle("\u{f196}", forState: UIControlState.Normal)
        plusButton!.setTitleColor(Colors.normalChangeModeColor, forState: UIControlState.Normal)
        plusButton!.setTitleColor(Colors.pressedChangeModeColor, forState: UIControlState.Highlighted)
        plusButton!.titleLabel!.font = Fonts.changeModeButton
        let plusBarButtonItem = UIBarButtonItem(customView: plusButton!)
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = plusBarButtonItem
        pianoNavigationViewController?.customNavigationItem.title = "Chord Progression"
        let menuButton = pianoNavigationViewController?.menuButton
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton!)
    }

}
