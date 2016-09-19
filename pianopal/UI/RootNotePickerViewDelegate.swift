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
    var navigationItem: UINavigationItem?
    
    init(navigationItem: UINavigationItem) {
        self.navigationItem = navigationItem
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let splitName = navigationItem!.title!.components(separatedBy: " ")
        navigationItem!.title = (Note(rawValue: row)?.simpleDescription())! + " " + splitName[1]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerView.frame.height / 3.0
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.width
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel;
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            
            pickerLabel?.font = Fonts.pickerItem
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        pickerLabel?.text = Note(rawValue: row)?.simpleDescription()
        return pickerLabel!;
    }
}
