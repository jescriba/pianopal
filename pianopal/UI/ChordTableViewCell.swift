//
//  ChordTableViewCell.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/17/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class ChordTableViewCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = Colors.tableBackground
        textLabel?.font = Fonts.tableItem
        textLabel?.textAlignment = NSTextAlignment.center
        
        let bgView = UIView()
        bgView.backgroundColor = Colors.tableCellSelected
        selectedBackgroundView = bgView
    }
}
