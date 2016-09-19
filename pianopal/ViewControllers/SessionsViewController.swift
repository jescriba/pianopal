//
//  SessionsViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 8/24/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class SessionsViewController : UIViewController, PianoNavigationProtocol, UITableViewDataSource, UITableViewDelegate {
    

    var menuBarButton: UIBarButtonItem?
    var pianoNavigationViewController: PianoNavigationViewController?
    var tableView: UITableView?
    var sessions:  [PianoSession]?
    
    override func viewDidLoad() {
        navigationController!.interactivePopGestureRecognizer?.isEnabled = false
        view.backgroundColor = Colors.chordTableBackgroundColor
        
        tableView = UITableView()
        tableView?.delegate = self
        tableView?.dataSource = self
        sessions = loadSessions()
        
        view.addSubview(tableView!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func loadSessions() -> [PianoSession] {
        return [PianoSession]()
    }
    
    func updateNavigationItem() {
        pianoNavigationViewController = navigationController as? PianoNavigationViewController
        pianoNavigationViewController?.customNavigationItem.titleView = nil
        pianoNavigationViewController?.customNavigationItem.title = "Sessions"
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = nil
        menuBarButton = UIBarButtonItem(customView: pianoNavigationViewController!.menuButton)
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = menuBarButton
        let saveButton = UIBarButtonItem(customView: pianoNavigationViewController!.saveSessionButton)
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = saveButton
    }
    
}
