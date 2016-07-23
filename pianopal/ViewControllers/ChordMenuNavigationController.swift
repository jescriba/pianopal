//
//  ChordMenuNavigationController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/19/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class ChordMenuNavigationController: UINavigationController {
    let customNavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: Dimensions.toolBarWidth, height:Dimensions.toolBarHeight))
    let customNavigationItem = UINavigationItem(title: "Chord Progression")
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBar.hidden = true
        
        UINavigationBar.appearance().titleTextAttributes = ["Font": Fonts.changeToolbarAction!]
        customNavigationBar.translucent = false
        customNavigationBar.barTintColor = Colors.toolBarBackground
        customNavigationBar.setItems([customNavigationItem], animated: false)
        view.addSubview(customNavigationBar)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
