//
//  RootNotePickerViewDelegate.swift
//  pianotools
//
//  Created by joshua on 6/14/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class RootNotePickerViewDelegate : NSObject, UIPickerViewDelegate {
    var nameLabel: UILabel?
    
    init(nameLabel: UILabel) {
        self.nameLabel = nameLabel
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let splitName = nameLabel!.text?.componentsSeparatedByString(" ")
        nameLabel!.text = (Note(rawValue: row)?.simpleDescription())! + " " + splitName![1]
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerView.frame.height / 3.0
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.width
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel;
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            
            pickerLabel?.font = Fonts.pickerItem
            pickerLabel?.textAlignment = NSTextAlignment.Center
        }
        pickerLabel?.text = Note(rawValue: row)?.simpleDescription()
        return pickerLabel!;
    }
}