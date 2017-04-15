//
//  SessionTableViewCell.swift
//  pianopal
//
//  Created by Joshua Escribano on 10/4/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

protocol SessionDelegate {
    func endEditing()
}

class SessionTableViewCell : UITableViewCell {
    let textField = UITextField()
    var delegate: SessionDelegate?
    var session: Session? {
        didSet {
            textLabel?.text = session?.name
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Colors.tableBackground
        textLabel?.font = Fonts.tableItem
        textLabel?.textAlignment = NSTextAlignment.center
        
        let bgView = UIView()
        textField.isHidden = true
        bgView.addSubview(textField)
        bgView.backgroundColor = Colors.tableCellSelected
        selectedBackgroundView = bgView
    }
    
    func beginEditing() {
        if let textLabel = textLabel {
            textField.isHidden = false
            textField.frame = textLabel.bounds
            textField.font = Fonts.tableItem
            textField.textAlignment = .center
            textField.placeholder = textLabel.text
            textField.delegate = self
            textLabel.text = ""
            textField.returnKeyType = .done
            textField.becomeFirstResponder()
        }
    }
}

extension SessionTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text
        if text != nil && !text!.isEmpty {
            session?.name = text
            textLabel?.text = text
            SessionManager.saveSessions()
        } else {
            textLabel?.text = textField.placeholder
        }
        textField.isHidden = true
        delegate?.endEditing()
    }

}
