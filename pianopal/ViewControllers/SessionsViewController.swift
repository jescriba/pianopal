//
//  SessionsViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 8/24/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class SessionsViewController : UIViewController, PianoNavigationProtocol, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    let editSessionButton = UIButton(frame: Dimensions.leftRightBarButtonRect)
    let newSessionButton = UIButton(frame: Dimensions.rightBarButtonRect)
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
    
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let currentSessionName = Globals.session?.name
            let sessionName = Globals.sessions[indexPath.row].name
            if Globals.sessions.count > 1 && sessionName != currentSessionName {
                Globals.sessions.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !tableView.isEditing {
            // Load
            loadSession(indexPath: indexPath)
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.reloadData()
        } else {
            // Handle editing
            let cell = tableView.cellForRow(at: indexPath)
            let label = cell?.textLabel
            let text = label?.text
            label?.text = ""
            let frame = label?.bounds
            let textField = UITextField(frame: frame!)
            textField.font = Fonts.tableItem
            textField.textAlignment = .center
            textField.placeholder = text
            textField.delegate = self
            textField.returnKeyType = .done
            cell?.addSubview(textField)
            textField.becomeFirstResponder()
        }
    }
    
//    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
//        
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var newName: String?
        let indexPath = tableView?.indexPathForSelectedRow
        if let index = indexPath {
            let text = textField.text
            let cell = tableView?.cellForRow(at: index)
            if text != nil && !text!.isEmpty {
                newName = SessionManager.uniqueSessionName(text!)
                cell?.textLabel?.text = newName

            } else {
                newName = SessionManager.uniqueSessionDateName()
                cell?.textLabel?.text = newName
            }
        }
        Globals.session?.name = newName ?? "welp"
        SessionManager.saveSessions()
        textField.removeFromSuperview()
        tableView?.isEditing = false
    }
    
    func loadSession(indexPath: IndexPath) {
        // TODO animation
        let cell = tableView?.cellForRow(at: indexPath)
        let sessionName = cell?.textLabel?.text
        SessionManager.loadSession(sessionName!)
    }
    
    func newSession() {
        let dateString = SessionManager.uniqueSessionDateName()
        let newSession = Session(name: dateString)
        Globals.sessions.insert(newSession, at: 0)
        SessionManager.saveSessions()
        tableView?.reloadData()
    }
    
    func editSessions() {
        if !tableView!.isEditing {
            tableView?.setEditing(true, animated: true)
        } else {
            tableView?.setEditing(false, animated: true)
        }
    }
    
    func updateNavigationItem() {
        pianoNavigationViewController?.customNavigationItem.titleView = nil
        pianoNavigationViewController?.customNavigationItem.title = "Sessions"
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = nil
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton!)
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItems = [UIBarButtonItem(customView: newSessionButton), UIBarButtonItem(customView: editSessionButton)]
    }
}
