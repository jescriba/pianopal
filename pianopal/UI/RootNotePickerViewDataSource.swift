//
//  RootNotePickerViewDataSource.swift
//  pianotools
//
//  Created by joshua on 6/14/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class RootNotePickerViewDataSource : NSObject, UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.totalNotes
    }
}