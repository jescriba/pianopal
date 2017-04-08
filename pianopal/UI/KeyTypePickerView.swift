//
//  KeyTypePickerView.swift
//  pianopal
//
//  Created by Joshua Escribano on 4/1/17.
//  Copyright © 2017 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

enum KeyType: Int {
    case unset, major, minor
    
    func simpleDescription() -> String {
        switch self {
        case .unset:
            return "-"
        case .major:
            return "Major"
        case .minor:
            return "Minor"
        }
    }
}

class KeyTypePickerView: UIPickerView {
    var keyDelegate: KeyDelegate?
    var keyTypes = [KeyType.unset, KeyType.major, KeyType.minor];
    
    override func willMove(toWindow newWindow: UIWindow?) {
        self.delegate = self
        self.dataSource = self
    }
    
}

extension KeyTypePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        keyDelegate?.keyChanged(note: nil, type: keyTypes[row])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return keyTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return keyTypes[row].simpleDescription()
    }
    
}
