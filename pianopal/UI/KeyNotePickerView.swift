//
//  KeyNotePickerView.swift
//  pianopal
//
//  Created by Joshua Escribano on 4/1/17.
//  Copyright © 2017 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

protocol KeyDelegate {
    func keyChanged(note: Note?, type: KeyType?)
}

class KeyNotePickerView: UIPickerView {
    var keyDelegate: KeyDelegate?
    var notes = Constants.orderedNotes
    
    override func willMove(toWindow newWindow: UIWindow?) {
        self.delegate = self
        self.dataSource = self
    }
    
}

extension KeyNotePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (row == 0) {
            keyDelegate?.keyChanged(note: nil, type: nil)
            return
        }
        
        keyDelegate?.keyChanged(note: notes[row - 1], type: nil)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "-"
        } else {
            return notes[row - 1].simpleDescription()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return notes.count + 1
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
}
