//
//  ScaleTableViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/24/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class ScaleTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PianoNavigationProtocol {
    
    let plusButton = UIButton(frame: Dimensions.rightBarButtonRect)
    var pianoNavigationViewController: PianoNavigationViewController?
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pianoNavigationViewController = navigationController as? PianoNavigationViewController
        navigationController!.interactivePopGestureRecognizer?.isEnabled = false
        let navBarOffset = (pianoNavigationViewController?.customNavigationBar.frame.height)! - (pianoNavigationViewController?.navigationBar.frame.height)!
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height - navBarOffset
        let tableViewRect = CGRect(x: 0, y: navBarOffset, width: width, height: height)
        tableView = UITableView(frame: tableViewRect)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView!.register(ScaleTableViewCell.self, forCellReuseIdentifier: "ScaleTableViewCell")
        tableView!.separatorColor = Colors.tableSeparator
        tableView!.rowHeight = 90
        tableView!.backgroundColor = Colors.tableBackground
        tableView!.allowsSelectionDuringEditing = true
        tableView!.tableFooterView = UIView()
        view.addSubview(tableView!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateNavigationItem()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScaleTableViewCell", for: indexPath) as! ScaleTableViewCell
        cell.scaleLabel!.text = Globals.scales[(indexPath as NSIndexPath).row].simpleDescription()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Globals.scales.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Globals.scales.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Session.save(Globals.scales)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let scale = Globals.scales[(sourceIndexPath as NSIndexPath).row]
        Globals.scales.remove(at: (sourceIndexPath as NSIndexPath).row)
        Globals.scales.insert(scale, at: (destinationIndexPath as NSIndexPath).row)
        Session.save(Globals.scales)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.isEditing = !tableView.isEditing
    }

    func updateNavigationItem() {
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = nil
        plusButton.setTitle("\u{f196}", for: .normal)
        plusButton.setTitleColor(Colors.normalRightBarButton, for: .normal)
        plusButton.setTitleColor(Colors.pressedRightBarButton, for: .highlighted)
        plusButton.titleLabel!.font = Fonts.plusButton
        let plusBarButtonItem = UIBarButtonItem(customView: plusButton)
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = plusBarButtonItem
        pianoNavigationViewController?.customNavigationItem.title = "Scale Progression"
        let menuButton = pianoNavigationViewController?.menuButton
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton!)
    }
}
