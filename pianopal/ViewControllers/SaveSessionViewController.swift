//
//  SaveSessionViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 9/18/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class SaveSessionViewController : UIViewController {
    var saveBoxView: UIView?
    var sessionName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let boxView = UIView(frame: Dimensions.saveBoxRect)
        saveBoxView = boxView
//        sessionName = NSDateComponents().calendar?.description
//        
        view.frame = Dimensions.saveBoxRect
        view.addSubview(saveBoxView!)        
    }
}
