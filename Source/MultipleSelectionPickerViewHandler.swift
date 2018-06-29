//
//  MultipleSelectionPickerViewHandler.swift
//  freighthaul
//
//  Created by Hayk Brsoyan on 6/27/18.
//  Copyright © 2018 Hayk Brsoyan. All rights reserved.
//

import UIKit

protocol MultiplePickerEventsDelegate: class {
    func pickerDidHide(text: String, owner: UIView?)
    func warningTextIsEmpty(owner: UIView?)
}

class MultipleSelectionPickerViewHandler: PickerViewHandler {
    private struct MultipleSelectionConstants {
        static let rowHeight: CGFloat = 44
    }
        
    weak var owner: UIView?
    weak var multiSelectionDelegate: MultiplePickerEventsDelegate?
    private var selectedRows: Set<Int> = Set(0..<USState.short().count)
    private var usStateCount = 0
    
    override var data: [String] {
        didSet {
            usStateCount = data.count
        }
    }
    
    override init(data: [String]) {
        super.init(data: data)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(select))
        picker.addGestureRecognizer(tap)
        tap.delegate = self
    }
    
    func configWith(parentVC: UIViewController, owner: UIView?, data: [String], onSelectedTitle: ((_ text : String) -> Void)?) {
        configWith(parentVC: parentVC, data: data, onSelectedTitle: onSelectedTitle)
        self.owner = owner
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        guard let reusingView = view as? SelectionView else {
            let view = SelectionView.init(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width * 0.8, height: MultipleSelectionConstants.rowHeight))
            setData(view: view, row: row)
            return view
        }
        
        setData(view: reusingView, row: row)
        return reusingView
    }
    
    private func setData(view: SelectionView, row: Int) {
        let title = data[row]
        
        var type = view.type
        if selectedRows.contains(row) {
            type = .selected
        }
        view.config(type: type, text: title)
    }
    
    override func toolBar() -> CGFloat {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()
        
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(dismiss))
        let doneButton = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(select))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([closeButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        return toolBar.frame.height + picker.frame.height
    }
    
    @objc func select() {
        let row = picker.selectedRow(inComponent: 0)
        let view = picker.view(forRow: row, forComponent: 0)
        guard let selectedView = view as? SelectionView else { return }
        
        if row == 0 && !selectedRows.contains(row) {
            for idx in 1..<data.count {
                selectedRows.insert(idx)
            }
        } else if row == 0 && selectedRows.contains(row) {
            selectedRows.removeAll()
        }
        
        let selected = selectedView.select()
        if selected == true {
            selectedRows.insert(row)
            if selectedRows.count + 1 == usStateCount {
                selectedRows.insert(0)
            }
        } else {
            selectedRows.remove(row)
            selectedRows.remove(0)
        }
        picker.reloadAllComponents()
    }
    
    override func dismiss() {
        let text = title()
        if !text.isEmpty {
            self.multiSelectionDelegate?.pickerDidHide(text: title(), owner: owner)
        } else {
            self.multiSelectionDelegate?.warningTextIsEmpty(owner: owner)
        }
        super.dismiss()
    }
    
    private func title() -> String {
        var str = ""
        
        if selectedRows.contains(0) {
            str = USState.short().first!
        } else if selectedRows.count > 0 {
            str = USState.short()[selectedRows.first!]
            
            for idx in selectedRows.dropFirst() {
                str = str + ", " + USState.short()[idx]
            }
        }
        
        return str
    }
}

extension MultipleSelectionPickerViewHandler: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if otherGestureRecognizer is UITapGestureRecognizer && gestureRecognizer is UITapGestureRecognizer {
            if let row = selectedRow {
                let selectedView = picker.view(forRow: row, forComponent: 0)
                if selectedView?.frame.contains(otherGestureRecognizer.location(in: selectedView)) == true {
                    select()
                }
            }
        }
        return false
    }
}



