//
//  ChordTypePickerViewDataSource.swift
//  pianotools
//
//  Created by joshua on 6/14/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class ChordTypePickerViewDataSource : NSObject, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.totalChordTypes
    }
}
