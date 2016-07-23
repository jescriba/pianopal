//
//  PianoNavigationViewController.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/23/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class PianoNavigationViewController: UINavigationController {
    let customNavigationBar = UINavigationBar(frame: Dimensions.toolbarRect)
    let customNavigationItem = UINavigationItem(title: "Piano")
    let menuButton = UIButton(frame: Dimensions.menuButtonRect)
    let changeModeButton = UIButton(frame: Dimensions.changeModeButtonRect)

    override func viewDidLoad() {
        super.viewDidLoad()

        UINavigationBar.appearance().titleTextAttributes = ["Font": Fonts.changeToolbarAction!]
        navigationController?.navigationBar.hidden = true
        customNavigationBar.translucent = false
        customNavigationBar.barTintColor = Colors.toolBarBackground
        customNavigationBar.setItems([customNavigationItem], animated: false)
        view.addSubview(customNavigationBar)
        
        menuButton.setTitle("\u{f0c9}", forState: UIControlState.Normal)
        menuButton.titleLabel!.font = Fonts.menuButton
        menuButton.setTitleColor(Colors.normalMenuButtonColor, forState: UIControlState.Normal)
        menuButton.setTitleColor(Colors.presssedMenuButtonColor, forState: UIControlState.Highlighted)
        menuButton.targetForAction(#selector(goToMenu), withSender: nil)
        
        changeModeButton.setTitle("\u{f105}", forState: UIControlState.Normal)
        changeModeButton.titleLabel!.font = Fonts.changeModeButton
        changeModeButton.setTitleColor(Colors.normalChangeModeColor, forState: UIControlState.Normal)
        changeModeButton.setTitleColor(Colors.pressedChangeModeColor, forState: UIControlState.Highlighted)
        changeModeButton.addTarget(self, action: #selector(changeMode), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func goToMenu() {
        // TODO
    }
    
    func changeMode() {
        switch topViewController {
        case _ as ChordViewController:
            popViewControllerAnimated(false)
            pushViewController(ScaleViewController(), animated: false)
        case _ as ScaleViewController:
            popViewControllerAnimated(false)
            pushViewController(IdentifyViewController(), animated: false)
        case _ as IdentifyViewController:
            popViewControllerAnimated(false)
            pushViewController(ChordViewController(), animated: false)
        default:
            break
        }
    }
}
