//
//  MultipleSelectionPickerViewHandler.swift
//  freighthaul
//
//  Created by Hayk Brsoyan on 6/27/18.
//  Copyright © 2018 Hayk Brsoyan. All rights reserved.
//

import UIKit

class MultipleSelectionPickerViewHandler: PickerViewHandler, MultipleSelectionPickerScrollDelegate {
    private struct MultipleSelectionConstants {
        static let rowHeight: CGFloat = 44
    }
    
    private lazy var selectedRows: Set<Int> = {
        return Set(0 ..< data.count())
    }()
    
    private var itemCount = 0
    private var scrollHelper: MultipleSelectionPickerScrollHelper?
    
    override var data: PickerData {
        didSet {
            itemCount = data.count()
        }
    }
    
    override init(data: PickerData) {
        super.init(data: data)
        let tap = UITapGestureRecognizer.init(target: self, action: nil)
        picker.addGestureRecognizer(tap)
        
        scrollHelper = MultipleSelectionPickerScrollHelper(owner: self)
        scrollHelper?.delegate = self
        tap.delegate = self.scrollHelper
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
        let title = data.long(for: row)
        
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
        
        let closeButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismiss))
        let doneButton = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(select))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([closeButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        return toolBar.frame.height + picker.frame.height
    }
    
    @objc func select() {
        let row = picker.selectedRow(inComponent: 0)
        selectRow(row: row)
    }
    
    private func selectRow(row: Int) {
        let view = picker.view(forRow: row, forComponent: 0)
        guard let selectedView = view as? SelectionView else { return }
        
        if row == 0 && !selectedRows.contains(row) {
            selectedRows = Set(0 ..< data.count())
        } else if row == 0 && selectedRows.contains(row) {
            selectedRows.removeAll()
        }
        
        let selected = selectedView.select()
        if selected == true {
            selectedRows.insert(row)
            if selectedRows.count + 1 == itemCount {
                selectedRows.insert(0)
            }
        } else {
            selectedRows.remove(row)
            selectedRows.remove(0)
        }
        
        DispatchQueue.main.async {
            self.picker.reloadAllComponents()
        }
    }
    
    override func selectedRowData() -> (title: String, ids: [Int]) {
        var str = ""
        var ids = [Int]()
        
        let selected = selectedRows.sorted()
        
        if selected.contains(0) {
            str = data.short(for: 0)
        } else if selectedRows.count > 0 {
            
            let first = selected.first!
            str = data.short(for: first)
            ids.append(data.id(for: first))
            
            for idx in selected.dropFirst() {
                str = str + ", " + data.short(for: idx)
                ids.append(data.id(for: idx))
            }
        }
        
        if str.isEmpty == true {
            str = data.short(for: 0)
            selectRow(row: 0)
            self.delegate?.pickerTextIsEmpty(owner: owner)
        }
        
        return (str, ids)
    }
    
    public func isSelectInRow(gestureRecognizer: UIGestureRecognizer) -> Bool {
        let selectedView = picker.view(forRow: selectedRow, forComponent: 0)
        if selectedView?.frame.contains(gestureRecognizer.location(in: selectedView)) == true {
            return true
        }
        return false
    }
}



