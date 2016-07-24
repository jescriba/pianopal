//
//  ChordTypePickerViewDelegate.swift
//  pianotools
//
//  Created by joshua on 6/14/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import UIKit

class ChordTypePickerViewDelegate : NSObject, UIPickerViewDelegate {
    var navigationItem: UINavigationItem?
    
    init(navigationItem: UINavigationItem) {
        self.navigationItem = navigationItem
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let splitName = navigationItem!.title!.componentsSeparatedByString(" ")
        navigationItem!.title = splitName[0] + " " + "\(ChordType(rawValue: row)!)"
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
        pickerLabel?.text = "\(ChordType(rawValue: row)!)"
        return pickerLabel!;
    }
    
}