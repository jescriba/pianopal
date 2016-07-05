//
//  ScaleTypePickerViewDelegate.swift
//  pianotools
//
//  Created by Joshua Escribano on 6/15/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class ScaleTypePickerViewDelegate : NSObject, UIPickerViewDelegate {
    var scaleNameLabel: UILabel?
    
    init(scaleNameLabel: UILabel) {
        self.scaleNameLabel = scaleNameLabel
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let splitName = scaleNameLabel!.text?.componentsSeparatedByString(" ")
        scaleNameLabel!.text = splitName![0] + " " + "\(ScaleType(rawValue: row)!)"
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
        pickerLabel?.text = "\(ScaleType(rawValue: row)!)"
        return pickerLabel!;
    }
    
}