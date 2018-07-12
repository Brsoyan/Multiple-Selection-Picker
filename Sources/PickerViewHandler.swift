//
//  PickerViewHandler.swift
//  freighthaul
//
//  Created by Hayk Brsoyan on 6/8/18.
//  Copyright © 2018 Hayk Brsoyan. All rights reserved.
//

import UIKit

public protocol PickerDelegate: class {
    func pickerDidHide(text: String, owner: UIView?, ids:[Int])
    func pickerTextIsEmpty(owner: UIView?)
}

public class PickerViewHandler: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    public weak var delegate: PickerDelegate?
    
    private(set) var textField: UITextField
    
    internal var data: (Any & PickerData)
    internal var picker = PickerView.init()
    internal var numberOfComponents = 1
    internal var selectedRow: Int = 0
    
    internal var leftButtonText: String?
    internal var rightButtonText: String?
    internal var tintColor: UIColor?
    
    weak var owner: UIView?
    private var pickerViewHeight: CGFloat = 0.0
    
    var onSelectedTitle: ((_ text : String) -> Void)?
    weak var parentVC: UIViewController? {
        didSet {
            configPicker()
        }
    }
    
    lazy var pickerDidHide: () -> Void = { [weak self] in
        guard let `self` = self else { return }
        
        let data = self.selectedRowData()
        let title = data.title
        let ids = data.ids
        
        self.delegate?.pickerDidHide(text: title, owner: self.owner, ids: ids)
    }
    
    public init(data: PickerData) {
        self.textField = UITextField.init(frame: .zero)
        self.data = data
    }
    
    public func configWith(parentVC: UIViewController, onSelectedTitle: ((_ text : String) -> Void)?) {
        presentPicker(parentVC: parentVC, onSelectedTitle: onSelectedTitle)
    }
    
    public func configWith(parentVC: UIViewController, owner: UIView?, data: PickerData?, leftButtonText: String?, rightButtonText: String?, tintColor: UIColor?, onSelectedTitle: ((_ text : String) -> Void)?) {
        
        self.leftButtonText = leftButtonText
        self.rightButtonText = rightButtonText
        self.tintColor = tintColor
        
        configWith(parentVC: parentVC, onSelectedTitle: onSelectedTitle)
        self.owner = owner
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
        
        selectedRow = 0
    }
    
    internal func toolBar() -> CGFloat {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        var color = UIColor.blue
        if let tintColor = self.tintColor {
            color = tintColor
        }
        toolBar.tintColor = color
        toolBar.sizeToFit()
        
        var rightText = "Done"
        if let txt = self.rightButtonText {
            rightText = txt
        }
        let doneButton = UIBarButtonItem(title: rightText, style: .plain, target: self, action: #selector(dismiss))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        return toolBar.frame.height + picker.frame.height
    }
    
    func title(for row: Int, component: Int?) -> String {
        return data.long(for: row)
    }
    
    func updateData() {
        // override if needed in child class
    }
    
    func stopUpdate() {
        // override if needed in child class
    }
    
    func count() -> Int {
        return data.count()
    }
    
    
    // MARK: UIPickerViewDelegate, UIPickerViewDataSource
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfComponents
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return count()
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return title(for: row, component: component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
        setTextOnCurrentView(row: row, component: component)
    }
    
    internal func setTextOnCurrentView(row: Int, component: Int?) {
        onSelectedTitle?(title(for: row, component: component))
    }
    
    internal func selectedRowData() -> (title: String, ids: [Int]) {
        return (title(for: self.selectedRow, component: 0), [Int]())
    }
    
    @objc func dismiss() {
        if selectedRow == 0 {
            setTextOnCurrentView(row: 0, component: nil)
        }
        self.parentVC?.view.endEditing(true)
    }
}








