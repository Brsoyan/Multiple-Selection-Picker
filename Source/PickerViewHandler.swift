//
//  PickerViewHandler.swift
//  freighthaul
//
//  Created by Hayk Brsoyan on 6/8/18.
//  Copyright © 2018 Hayk Brsoyan. All rights reserved.
//

import UIKit

class PickerViewHandler: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: PickerEventsDelegate?
    
    private(set) var textField: UITextField
    
    internal var data: [String]
    internal var picker = PickerView.init()
    internal var numberOfComponents = 1
    internal var selectedRow: Int?
    
    private var pickerViewHeight: CGFloat = 0.0
    
    var onSelectedTitle: ((_ text : String) -> Void)?
    weak var parentVC: UIViewController? {
        didSet {
            configPicker()
        }
    }
    
    init(data: [String]) {
        self.textField = UITextField.init(frame: .zero)
        self.data = data
    }
    
    func configWith(parentVC: UIViewController, onSelectedTitle: ((_ text : String) -> Void)?) {
        presentPicker(parentVC: parentVC, onSelectedTitle: onSelectedTitle)
    }
    
    func configWith(parentVC: UIViewController, data: [String]?, onSelectedTitle: ((_ text : String) -> Void)?) {
        presentPicker(parentVC: parentVC, onSelectedTitle: onSelectedTitle)
        if let data = data {
            self.data = data
        }
    }
    
    internal func presentPicker(parentVC: UIViewController, onSelectedTitle: ((_ text : String) -> Void)?) {
        self.parentVC = parentVC
        self.textField.becomeFirstResponder()
        self.onSelectedTitle = onSelectedTitle
    }
    
    private func configPicker() {
        self.parentVC?.view.addSubview(textField)
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        picker.selectRow(0, inComponent: 0, animated: false)
        picker.pickerDidHide = pickerDidHide
        
        textField.inputView = picker
        pickerViewHeight = self.toolBar()
        
        selectedRow = nil
        delegate?.pickerWillShow(height: pickerViewHeight)
    }
    
    internal func toolBar() -> CGFloat {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismiss))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        return toolBar.frame.height + picker.frame.height
    }
    
    func title(for row: Int, component: Int?) -> String {
        return data[row]
    }
    
    func updateData() {
        // override if needed in child class
    }
    
    func stopUpdate() {
        // override if needed in child class
    }
    
    func count() -> Int {
        return data.count
    }
    
    lazy var pickerDidHide: () -> Void = { [weak self] in
        guard let `self` = self else { return }
        self.delegate?.pickerDidHide(height: self.pickerViewHeight)
    }
    
    // MARK: UIPickerViewDelegate, UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return count()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return title(for: row, component: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
        setTextOnCurrentView(row: row, component: component)
    }
    
    internal func setTextOnCurrentView(row: Int, component: Int?) {
        onSelectedTitle?(title(for: row, component: component))
    }
    
    @objc func dismiss() {
        if selectedRow == nil {
            setTextOnCurrentView(row: 0, component: nil)
        }
        self.parentVC?.view.endEditing(true)
    }
}








