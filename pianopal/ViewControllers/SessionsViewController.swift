//
//  SessionsViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 8/24/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

// TODO: 
// Auto-save PianoSession and store as item in table cell that
// can be loaded / edited (name changed) but then have the
// bar button always be 'new' to create a new session and 'load'
// only when a table item is selected

class SessionsViewController : UIViewController, PianoNavigationProtocol, UITableViewDataSource, UITableViewDelegate {
    
    let sessionRightButton = UIButton(frame: Dimensions.rightBarButtonRect)
    var isLoadMode = false
    var menuButton: UIButton?
    var pianoNavigationViewController: PianoNavigationViewController?
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.tableBackground
        pianoNavigationViewController = navigationController as? PianoNavigationViewController
        menuButton = pianoNavigationViewController!.menuButton
        navigationController!.interactivePopGestureRecognizer?.isEnabled = false
        view.backgroundColor = Colors.tableBackground
        
        let navBarOffset = (pianoNavigationViewController?.customNavigationBar.frame.height)! - (pianoNavigationViewController?.navigationBar.frame.height)!
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height - navBarOffset
        let tableViewRect = CGRect(x: 0, y: navBarOffset, width: width, height: height)
        tableView = UITableView(frame: tableViewRect)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(SessionTableViewCell.self, forCellReuseIdentifier: "SessionTableViewCell")
        tableView!.rowHeight = 90
        tableView!.separatorColor = Colors.tableSeparator
        tableView!.backgroundColor = Colors.tableBackground
        tableView!.allowsSelectionDuringEditing = true
        tableView!.tableFooterView = UIView()
        
        view.addSubview(tableView!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateNavigationItem()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Globals.sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionTableViewCell") as! SessionTableViewCell
        cell.textLabel?.text = Globals.sessions[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = tableView.cellForRow(at: indexPath)
        if cell != nil && cell!.isSelected {
            cell?.setSelected(false, animated: true)
            sessionRightButton.setTitle("New", for: .normal)
            sessionRightButton.sizeToFit()
            isLoadMode = false
            return nil
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sessionRightButton.setTitle("Load", for: .normal)
        sessionRightButton.sizeToFit()
        isLoadMode = true
    }
    
    func sessionRightButtonPressed() {
        if isLoadMode {
            // Load session
            let selectedIndexPath = tableView?.indexPathForSelectedRow
            if let indexPath = selectedIndexPath {
                let cell = tableView?.cellForRow(at: indexPath)
                let sessionName = cell?.textLabel?.text
                if let name = sessionName {
                    let session = SessionManager.loadSession(name)
                    if !Globals.sessions.contains(session) {
                        Globals.sessions.insert(session, at: 0)
                    }
                    cell?.setSelected(false, animated: true)
                    sessionRightButton.setTitle("New", for: .normal)
                    sessionRightButton.sizeToFit()
                    isLoadMode = false
                    SessionManager.saveSessions()
                    tableView?.reloadData()
                }
            }
        } else {
            // Create new session
            let newSession = Session(name: String("Current Session"))
            Globals.session?.name = String(arc4random())
            Globals.sessions.insert(newSession, at: 0)
            SessionManager.saveSessions()
            tableView?.reloadData()
        }
    }
    
    func updateNavigationItem() {
        pianoNavigationViewController?.customNavigationItem.titleView = nil
        pianoNavigationViewController?.customNavigationItem.title = "Sessions"
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = nil
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton!)
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: sessionRightButton)
    }
}
