//
//  IdentifyViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/23/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class IdentifyViewController: UIViewController, PianoNavigationProtocol {
    let pianoView = PianoView(frame: Dimensions.pianoRect)
    var pianoNavigationViewController: PianoNavigationViewController?
    var menuBarButton: UIBarButtonItem?
    var changeModeBarButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pianoView)
    }
    
    func updateNavigationItem() {
        pianoNavigationViewController = (navigationController as! PianoNavigationViewController)
        changeModeBarButton = UIBarButtonItem(customView: pianoNavigationViewController!.changeModeButton)
        pianoNavigationViewController?.customNavigationItem.leftBarButtonItem = nil
        pianoNavigationViewController?.customNavigationItem.rightBarButtonItem = changeModeBarButton
        pianoNavigationViewController!.customNavigationItem.title = "Identify Chords"
    }

}
