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
    
    private var pickerHandler = PickerViewHandler(data: [])
    private var pickerDate = DatePickerViewHandler(data: [])
    private var multiSelectionPicker = MultipleSelectionPickerViewHandler(data: [])
    
    lazy var onItemSelected: (String) -> Void = { [weak self] title in
        self?.titileLabel.text = title
    }
    
    lazy var onItemSelectedDate: (_ day: Int, _ month: String, _ year: Int) -> Void = { [weak self] day, month, year in
        print("day = \(day) , month = \(month) , year = \(year)")
    }

    @IBAction func picker(_ sender: UIButton) {
        let data = ["item 1", "item 2", "item 3", "item 4", "item 5", "item 6", "item 7",]
        pickerHandler.delegate = self
        pickerHandler.configWith(parentVC: self, data: data, onSelectedTitle: onItemSelected)
    }
    
    @IBAction func date(_ sender: UIButton) {
        pickerDate.delegate = self
        pickerDate.configWith(parentVC: self, onSelectedTitle: nil)
    }
    
    @IBAction func multiSelection(_ sender: UIButton) {
        multiSelectionPicker.multiSelectionDelegate = self
        multiSelectionPicker.configWith(parentVC: self, owner: sender, data: USState.long(), onSelectedTitle: onItemSelected)
    }
}

extension ViewController: PickerEventsDelegate {
    func pickerWillShow(height: CGFloat) {
        // picker view will show
    }
    
    func pickerDidHide(height: CGFloat) {
        // picker view did hide
    }
}


extension ViewController: MultiplePickerEventsDelegate {
    func pickerDidHide(text: String, owner: UIView?) {
        if let btn = owner as? UIButton {
            btn.titleLabel?.text = text
        }
    }
    
    func warningTextIsEmpty(owner: UIView?) {
        // shake :) please choose min one field
        owner?.shake(duration: 2, repeatCount: 6, shakeSize: 10)
    }
}
