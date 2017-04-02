//
//  KeyNotePickerView.swift
//  pianopal
//
//  Created by Joshua Escribano on 4/1/17.
//  Copyright © 2017 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class KeyNotePickerView: UIPickerView {
    
    override func willMove(toWindow newWindow: UIWindow?) {
        self.delegate = self
        self.dataSource = self
    }
    
}

//TODO
extension KeyNotePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "-"
        } else {
            return Constants.orderedNotes[row - 1].simpleDescription()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.totalNotes + 1
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
}
