//
//  ChordProgressionMenuViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/17/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class ChordTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PianoNavigationProtocol {
    
    let plusButton = UIButton(frame: Dimensions.rightBarButtonRect)
    var pianoNavigationViewController: PianoNavigationViewController?
    var menuButton: UIButton?
    var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.interactivePopGestureRecognizer?.isEnabled = false
        pianoNavigationViewController = navigationController as? PianoNavigationViewController
        let navBarOffset = (pianoNavigationViewController?.customNavigationBar.frame.height)! - (pianoNavigationViewController?.navigationBar.frame.height)!
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height - navBarOffset
        let tableViewRect = CGRect(x: 0, y: navBarOffset, width: width, height: height)
        tableView = UITableView(frame: tableViewRect)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView!.register(ChordTableViewCell.self, forCellReuseIdentifier: "ChordTableViewCell")
        tableView!.rowHeight = 90
        tableView!.separatorColor = Colors.tableSeparator
        tableView!.backgroundColor = Colors.tableBackground
        tableView!.allowsSelectionDuringEditing = true
        tableView!.tableFooterView = UIView()
        view.addSubview(tableView!)
        
        menuButton = pianoNavigationViewController?.menuButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView?.reloadData()
        
        updateNavigationItem()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChordTableViewCell", for: indexPath) as! ChordTableViewCell
        cell.textLabel?.text = Globals.chords[(indexPath as NSIndexPath).row].simpleDescription()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Globals.chords.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Globals.session?.chords.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            SessionManager.saveSession(Globals.session)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let chord = Globals.chords[(sourceIndexPath as NSIndexPath).row]
        Globals.session?.chords.remove(at: (sourceIndexPath as NSIndexPath).row)
        Globals.session?.chords.insert(chord, at: (destinationIndexPath as NSIndexPath).row)
        SessionManager.saveSession(Globals.session)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.isEditing = !tableView.isEditing
    }

    func updateNavigationItem() {
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = nil
        plusButton.setTitle("\u{f055}", for: .normal)
        plusButton.setTitleColor(Colors.normalRightBarButton, for: .normal)
        plusButton.setTitleColor(Colors.pressedRightBarButton, for: .highlighted)
        plusButton.titleLabel!.font = Fonts.plusButton
        let plusBarButtonItem = UIBarButtonItem(customView: plusButton)
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = plusBarButtonItem
        pianoNavigationViewController?.customNavigationItem.title = "Chord Progression"
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton!)
    }
}
