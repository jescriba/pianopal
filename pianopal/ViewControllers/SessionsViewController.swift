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
    var tableViewRect: CGRect?
    var nameTextField: UITextField?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.tableBackground
        pianoNavigationViewController = navigationController as? PianoNavigationViewController
        menuButton = pianoNavigationViewController!.menuButton
        navigationController!.interactivePopGestureRecognizer?.isEnabled = false
        view.backgroundColor = Colors.tableBackground
        
        // Fix this nav bar offset behavior when done editing
        let navBarOffset = (pianoNavigationViewController?.customNavigationBar.frame.height)!
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height - navBarOffset
        tableViewRect = CGRect(x: 0, y: navBarOffset, width: width, height: height)
        tableView = UITableView(frame: tableViewRect!)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(SessionTableViewCell.self, forCellReuseIdentifier: "SessionTableViewCell")
        tableView!.rowHeight = 90
        tableView!.separatorColor = Colors.tableSeparator
        tableView!.backgroundColor = Colors.tableBackground
        tableView!.allowsSelectionDuringEditing = true
        tableView!.tableFooterView = UIView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
        view.addSubview(tableView!)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject?
            if let val = value {
                let height = val.cgRectValue.size.height
                let inset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
                tableView?.contentInset = inset
                tableView?.scrollIndicatorInsets = inset
            }
        }
    }
    
    func keyboardDidHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.tableView?.contentInset = .zero
            self.tableView?.scrollIndicatorInsets = .zero
        })
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
        if indexPath.row == 0 {
            cell.textLabel?.layer.shadowOpacity = 0.8
            cell.textLabel?.backgroundColor = Colors.tableCellLoaded
        } else {
            cell.textLabel?.layer.shadowOpacity = 0
            cell.textLabel?.backgroundColor = Colors.tableBackground
        }
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
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        } else {
            // Handle editing
            if nameTextField != nil {
                // Already editing another cell
                nameTextField?.endEditing(true)
            }
            let cell = tableView.cellForRow(at: indexPath)
            let label = cell?.textLabel
            let text = label?.text
            label?.text = ""
            let frame = label?.bounds
            nameTextField = UITextField(frame: frame!)
            nameTextField!.font = Fonts.tableItem
            nameTextField!.textAlignment = .center
            nameTextField!.placeholder = text
            nameTextField!.delegate = self
            nameTextField!.returnKeyType = .done
            cell?.addSubview(nameTextField!)
            nameTextField!.becomeFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var newName: String?
        let text = textField.text
        let cell = textField.superview as! SessionTableViewCell
        let indexPath = tableView?.indexPath(for: cell)
        if text != nil && !text!.isEmpty {
            newName = SessionManager.uniqueSessionName(text!)
        } else {
            newName = Globals.sessions[indexPath!.row].name
        }
        cell.textLabel?.text = newName
        Globals.sessions[indexPath!.row].name = newName!
        SessionManager.saveSessions()
        textField.removeFromSuperview()
        nameTextField = nil
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
            if let tField = nameTextField {
                tField.endEditing(true)
            }
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
