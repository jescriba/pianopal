//
//  RootNotePickerView.swift
//  pianopal
//
//  Created by Joshua Escribano on 4/3/17.
//  Copyright © 2017 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class RootNotePickerView: UIPickerView {
    var chordDelegate: ChordDelegate?
    var notes = Constants.orderedNotes
    
    override func willMove(toWindow newWindow: UIWindow?) {
        self.delegate = self
        self.dataSource = self
    }
}

extension RootNotePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chordDelegate?.chordChanged(note: notes[row], type: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return notes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return notes[row].simpleDescription()
    }
    
}
