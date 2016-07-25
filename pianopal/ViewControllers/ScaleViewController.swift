//
//  ScaleViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/23/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class ScaleViewController: UIViewController, PianoNavigationProtocol {
    let pianoView = PianoView(frame: Dimensions.pianoRect)
    var pianoNavigationViewController: PianoNavigationViewController?
    var menuBarButton: UIBarButtonItem?
    var changeModeBarButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        automaticallyAdjustsScrollViewInsets = false
        updateNavigationItem()
        view.addSubview(pianoView)
    }
    
    func updateNavigationItem() {
        pianoNavigationViewController = (navigationController as! PianoNavigationViewController)
        menuBarButton = UIBarButtonItem(customView: pianoNavigationViewController!.menuButton)
        changeModeBarButton = UIBarButtonItem(customView: pianoNavigationViewController!.changeModeButton)
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = menuBarButton
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = changeModeBarButton
        pianoNavigationViewController!.customNavigationItem.title = "Piano Scales"
    }

}
