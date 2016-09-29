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
    
    let saveSessionButton = UIButton(frame: Dimensions.rightBarButtonRect)
    var menuButton: UIButton?
    var pianoNavigationViewController: PianoNavigationViewController?
    var tableView: UITableView?
    var sessions:  [PianoSession]?
    
    override func viewDidLoad() {
        pianoNavigationViewController = navigationController as? PianoNavigationViewController
        menuButton = pianoNavigationViewController!.menuButton
        navigationController!.interactivePopGestureRecognizer?.isEnabled = false
        view.backgroundColor = Colors.tableBackground
        tableView = UITableView()
        tableView?.delegate = self
        tableView?.dataSource = self
        sessions = loadSessions()
        
        view.addSubview(tableView!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateNavigationItem()
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
        pianoNavigationViewController?.customNavigationItem.titleView = nil
        pianoNavigationViewController?.customNavigationItem.title = "Sessions"
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = nil
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton!)
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveSessionButton)
    }
}
