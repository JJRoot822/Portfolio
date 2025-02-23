//
//  TagColorPickerDelegate.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 2/21/25.
//

import UIKit

class TagColorPickerDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.colors.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constants.colorNames[row]
    }
}
