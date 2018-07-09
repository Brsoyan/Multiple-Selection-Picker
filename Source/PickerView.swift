//
//  PickerView.swift
//  Picker
//
//  Created by Hayk Brsoyan on 6/29/18.
//  Copyright © 2018 Hayk Brsoyan. All rights reserved.
//

import UIKit

protocol PickerData: class {
    func id(for row: Int) -> Int
    func long(for row: Int) -> String
    func short(for row: Int) -> String
    func count() -> Int
}

class PickerView: UIPickerView {
    
    var pickerDidHide: (() -> Void)?
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        self.pickerDidHide?()
    }
}
