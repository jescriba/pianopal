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
    var sideMenuController: SlideMenuViewController?
    
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
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        // Prevent weird gesture behavior on the chord/scale tableviews
        if (touch.view != nil && String(touch.view!.dynamicType).containsString("UITableView")) {
            return false
        }
        return true
    }
    
    func panGestureRecognizer(recognizer: UIPanGestureRecognizer) {
        let topViewController = navController!.topViewController!
        if (topViewController is ScaleSelectorViewController || topViewController is ChordSelectorViewController) {
            return
        }
        
        let draggingLeftToRight = recognizer.velocityInView(view).x > 0
        let slideMenuViewController = navController!.slideMenuViewController!
        
        switch (recognizer.state) {
            case .Began:
                if (draggingLeftToRight && !slideMenuViewController.expanded) {
                    navController!.addSlideMenuPanel()
                }
            case .Changed:
                let newCenterX = navController!.view!.center.x + recognizer.translationInView(view).x
                if (newCenterX > view.center.x + SlideMenuViewController.offset) {
                    slideMenuViewController.expanded = true
                } else if (newCenterX > view.center.x) {
                    navController!.view.center.x = newCenterX
                    slideMenuViewController.expanded = false
                }
                recognizer.setTranslation(CGPointZero, inView: view)
            case .Ended:
                if (!slideMenuViewController.expanded) {
                    slideMenuViewController.collapsePanel()
                }
            default:
                break
        }
    }
    
}