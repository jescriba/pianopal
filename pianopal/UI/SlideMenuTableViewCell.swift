//
//  SlideMenuTableViewCell.swift
//  pianopal
//
//  Created by Joshua Escribano on 8/10/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class SlideMenuTableViewCell : UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let bgView = UIView()
        bgView.backgroundColor = Colors.navigationTablViewCellSelectedBackgroundColor
        selectedBackgroundView = bgView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        textLabel?.textAlignment = NSTextAlignment.Left
        textLabel?.frame.origin.x = 5
    }
}