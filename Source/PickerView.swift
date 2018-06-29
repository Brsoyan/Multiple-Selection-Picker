//
//  PickerView.swift
//  Picker
//
//  Created by Hayk Brsoyan on 6/29/18.
//  Copyright © 2018 Hayk Brsoyan. All rights reserved.
//

import UIKit

protocol PickerEventsDelegate: class {
    func pickerWillShow(height: CGFloat)
    func pickerDidHide(height: CGFloat)
}


class PickerView: UIPickerView {
    
    var pickerDidHide: (() -> Void)?
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        self.pickerDidHide?()
    }
}
