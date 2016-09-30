//
//  ScaleTableViewCell.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/24/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class ScaleTableViewCell: UITableViewCell {
    var scaleLabel: UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Colors.tableBackground
        scaleLabel = textLabel
        scaleLabel!.font = Fonts.tableItem
        scaleLabel!.textAlignment = NSTextAlignment.center
        
        let bgView = UIView()
        bgView.backgroundColor = Colors.tableCellSelected
        selectedBackgroundView = bgView
    }
}
