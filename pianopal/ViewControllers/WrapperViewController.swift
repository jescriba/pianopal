//
//  WrapperViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 8/9/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class WrapperViewController : UIViewController, UIGestureRecognizerDelegate {
    var navController: PianoNavigationViewController?
    
    convenience init(navigationController: PianoNavigationViewController) {
        self.init()
        
        self.navController = navigationController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizer))
        panRecognizer.delegate = self
        self.view.addGestureRecognizer(panRecognizer)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // Prevent weird gesture behavior on the chord/scale tableviews
        if (touch.view != nil && String(describing: type(of: touch.view!)).contains("UITableView")) {
            return false
        }
        return true
    }
    
    func panGestureRecognizer(_ recognizer: UIPanGestureRecognizer) {
        let topViewController = navController!.topViewController!
        if (topViewController is ScaleSelectorViewController || topViewController is ChordSelectorViewController) {
            return
        }
        
        let draggingLeftToRight = recognizer.velocity(in: view).x > 0
        let slideMenuViewController = navController!.slideMenuViewController
        
        switch (recognizer.state) {
            case .began:
                if (draggingLeftToRight && !slideMenuViewController.isExpanded) {
                    navController!.addSlideMenuPanel()
                }
            case .changed:
                let newCenterX = navController!.view!.center.x + recognizer.translation(in: view).x
                if (newCenterX > view.center.x + SlideMenuViewController.offset) {
                    slideMenuViewController.isExpanded = true
                } else if (newCenterX > view.center.x) {
                    navController!.view.center.x = newCenterX
                    slideMenuViewController.isExpanded = false
                }
                recognizer.setTranslation(CGPoint.zero, in: view)
            case .ended:
                if (!slideMenuViewController.isExpanded) {
                    slideMenuViewController.collapsePanel()
                }
            default:
                break
        }
    }
    
}
