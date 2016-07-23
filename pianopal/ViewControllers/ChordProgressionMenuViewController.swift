//
//  ChordProgressionMenuViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/17/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class ChordProgressionMenuViewController: UITableViewController {
    var chords = [Chord]()

    override func viewDidLoad() {
        super.viewDidLoad()

        chords.append(ChordGenerator.generateChord(Note.C, chordType: ChordType.Major))
        chords.append(ChordGenerator.generateChord(Note.D, chordType: ChordType.Minor))
        
        let customNavigationBar = (navigationController as! ChordMenuNavigationController).customNavigationBar
        
        let menuBarButton = UIBarButtonItem(title: "\u{f0c9}", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(goToPianoViewController))
        menuBarButton.setTitleTextAttributes(["Font": Fonts.menuButton!, NSForegroundColorAttributeName : Colors.normalMenuButtonColor], forState: UIControlState.Normal)
        menuBarButton.setTitleTextAttributes([NSForegroundColorAttributeName : Colors.presssedMenuButtonColor], forState: UIControlState.Highlighted)
        
        let addChordButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(goToPianoViewController))
        addChordButton.setTitleTextAttributes([NSForegroundColorAttributeName : Colors.normalMenuButtonColor], forState: UIControlState.Normal)
        addChordButton.setTitleTextAttributes([NSForegroundColorAttributeName : Colors.presssedMenuButtonColor], forState: UIControlState.Highlighted)
        
        customNavigationBar.topItem?.leftBarButtonItem = menuBarButton
        customNavigationBar.topItem?.rightBarButtonItem = addChordButton
        tableView.separatorColor = Colors.chordTableSeparatorColor
        tableView.rowHeight = 90
        tableView.backgroundColor = UIColor(CGColor: Colors.keyBorder)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ChordTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ChordTableViewCell
        cell.chordLabel.text = chords[indexPath.row].simpleDescription()
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chords.count
    }
    
    func goToPianoViewController() {
        UIApplication.sharedApplication().delegate!.window!?.rootViewController = PianoViewController(chords: chords)
    }

}
