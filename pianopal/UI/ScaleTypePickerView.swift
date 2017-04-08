//
//  ScaleTypePickerView.swift
//  pianopal
//
//  Created by Joshua Escribano on 4/6/17.
//  Copyright © 2017 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

protocol ScaleDelegate {
    func scaleChanged(note: Note?, type: ScaleType?)
}

class ScaleTypePickerView: UIPickerView {
    var scaleDelegate: ScaleDelegate?
    var scaleTypes = Constants.orderedScaleTypes
    
    override func willMove(toWindow newWindow: UIWindow?) {
        self.delegate = self
        self.dataSource = self
    }
}

extension ScaleTypePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        scaleDelegate?.scaleChanged(note: nil, type: scaleTypes[row])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return scaleTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(scaleTypes[row])"
    }
    
}
