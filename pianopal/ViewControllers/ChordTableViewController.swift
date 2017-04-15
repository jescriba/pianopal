//
//  ChordProgressionMenuViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/17/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class ChordTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PianoNavigationProtocol {
    
    let addChordButton = UIButton(frame: Dimensions.addChordRowButton)
    let plusButton = UIButton(frame: Dimensions.rightBarButtonRect)
    var pianoNavigationViewController: PianoNavigationViewController?
    var menuButton: UIButton?
    var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        navigationController!.interactivePopGestureRecognizer?.isEnabled = false
        pianoNavigationViewController = navigationController as? PianoNavigationViewController
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        let tableViewRect = CGRect(x: 0, y: Dimensions.toolbarRect.height, width: width, height: height)
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
        
        if (Globals.session?.chords.isEmpty ?? true) {
            addChordButton.setTitle("Get Started - Add a Chord", for: .normal)
            addChordButton.setTitleColor(.black, for: .normal)
            addChordButton.titleLabel?.font = Fonts.addChordRowButtonTitle
            addChordButton.addTarget(pianoNavigationViewController, action: #selector(PianoNavigationViewController.goToChordSelector), for: .touchUpInside)
            view.addSubview(addChordButton)
        }
        
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
        if Globals.chords.count > 0 {
            addChordButton.isHidden = true
        }
        return Globals.chords.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Globals.session?.chords.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            SessionManager.saveSessions()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let chord = Globals.chords[(sourceIndexPath as NSIndexPath).row]
        Globals.session?.chords.remove(at: (sourceIndexPath as NSIndexPath).row)
        Globals.session?.chords.insert(chord, at: (destinationIndexPath as NSIndexPath).row)
        SessionManager.saveSessions()
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
