//
//  ChordTypePickerView.swift
//  pianopal
//
//  Created by Joshua Escribano on 4/3/17.
//  Copyright © 2017 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

protocol ChordDelegate {
    func chordChanged(note: Note?, type: ChordType?)
}

class ChordTypePickerView: UIPickerView {
    var chordDelegate: ChordDelegate?
    var chordTypes = Constants.orderedChordTypes
    
    override func willMove(toWindow newWindow: UIWindow?) {
        self.delegate = self
        self.dataSource = self
    }
}

extension ChordTypePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chordDelegate?.chordChanged(note: nil, type: chordTypes[row])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return chordTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(chordTypes[row])"
    }
    
}
