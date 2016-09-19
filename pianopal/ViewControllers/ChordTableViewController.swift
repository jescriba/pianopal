//
//  ChordProgressionMenuViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/17/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class ChordTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PianoNavigationProtocol {
    var pianoNavigationViewController: PianoNavigationViewController?
    var chords = [Chord]()
    var tableView: UITableView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.interactivePopGestureRecognizer?.isEnabled = false

        let navBarOffset = (pianoNavigationViewController?.customNavigationBar.frame.height)! - (pianoNavigationViewController?.navigationBar.frame.height)!
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height - navBarOffset
        let tableViewRect = CGRect(x: 0, y: navBarOffset, width: width, height: height)
        tableView = UITableView(frame: tableViewRect)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView!.register(ChordTableViewCell.self, forCellReuseIdentifier: "ChordTableViewCell")
        tableView!.separatorColor = Colors.chordTableSeparatorColor
        tableView!.rowHeight = 90
        tableView!.backgroundColor = Colors.chordTableBackgroundColor
        tableView!.allowsSelectionDuringEditing = true
        tableView!.tableFooterView = UIView()
        view.addSubview(tableView!)
        
        updateNavigationItem()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChordTableViewCell", for: indexPath) as! ChordTableViewCell
        cell.chordLabel!.text = chords[(indexPath as NSIndexPath).row].simpleDescription()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chords.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            chords.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Session.save(chords: chords)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let chord = chords[(sourceIndexPath as NSIndexPath).row]
        chords.remove(at: (sourceIndexPath as NSIndexPath).row)
        chords.insert(chord, at: (destinationIndexPath as NSIndexPath).row)
        Session.save(chords: chords)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.isEditing = !tableView.isEditing
    }

    func updateNavigationItem() {
        pianoNavigationViewController = navigationController as? PianoNavigationViewController
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = nil
        let plusButton = pianoNavigationViewController?.addChordButton
        plusButton!.setTitle("\u{f196}", for: UIControlState())
        plusButton!.setTitleColor(Colors.normalRightBarButtonColor, for: UIControlState())
        plusButton!.setTitleColor(Colors.pressedRightBarButtonColor, for: UIControlState.highlighted)
        plusButton!.titleLabel!.font = Fonts.changeModeButton
        let plusBarButtonItem = UIBarButtonItem(customView: plusButton!)
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = plusBarButtonItem
        pianoNavigationViewController?.customNavigationItem.title = "Chord Progression"
        let menuButton = pianoNavigationViewController?.menuButton
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton!)
    }

}
