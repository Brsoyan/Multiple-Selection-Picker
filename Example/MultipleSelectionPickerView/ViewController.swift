//
//  ViewController.swift
//  Picker
//
//  Created by Hayk Brsoyan on 6/29/18.
//  Copyright © 2018 Hayk Brsoyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titileLabel: UILabel!
    @IBOutlet weak var states: UILabel!
    
    private var pickerDate = DatePickerViewHandler(data: DataForPicker())
    private var multiSelectionPicker = MultipleSelectionPickerViewHandler(data: USState.shared)
    
    lazy var onItemSelected: (String) -> Void = { [weak self] title in
        self?.titileLabel.text = title
    }
    
    lazy var onItemSelectedDate: (_ day: Int, _ month: String, _ year: Int) -> Void = { [weak self] day, month, year in
        print("day = \(day) , month = \(month) , year = \(year)")
    }
    
    
    @IBAction func date(_ sender: UIButton) {
        pickerDate.delegate = self
        pickerDate.configWith(parentVC: self, onSelectedTitle: nil)
    }
    
    @IBAction func multiSelection(_ sender: UIButton) {
        multiSelectionPicker.delegate = self
        multiSelectionPicker.configWith(parentVC: self, owner: sender, data: USState.shared, onSelectedTitle: onItemSelected)
    }
}


extension ViewController: PickerDelegate {
    func pickerDidHide(text: String, owner: UIView?, ids: [Int]) {
        states.text = text
        print("ids == \(ids)")
    }
    
    func pickerTextIsEmpty(owner: UIView?) {
        owner?.shake(duration: 0.5, repeatCount: 6, shakeSize: 20)
    }
}
