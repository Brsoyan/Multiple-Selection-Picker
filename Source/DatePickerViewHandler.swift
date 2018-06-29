//
//  DatePickerViewHandler.swift
//  freighthaul
//
//  Created by Hayk Brsoyan on 6/8/18.
//  Copyright © 2018 Hayk Brsoyan. All rights reserved.
//
import UIKit

class DatePickerViewHandler: PickerViewHandler {
    private var months = [String]()
    private var years = [Int]()
    private var days = [Int]()
    
    var day: Int = 0
    var month: Int = 0
    var year: Int = 0
    
    var onSelectedDate: ((_ day: Int, _ month: String, _ year: Int) -> Void)?
    
    override init(data: [String]) {
        super.init(data: data)
        self.commonSetup()
        self.numberOfComponents = 3
    }
    
    func commonSetup() {
        self.years = getYears()
        self.months = getMonths()
        self.days = Array(1...31)
    }
    
    private func getYears() -> [Int] {
        var years = [Int]()
        let year = Calendar.current.component(.year, from: Date())
        for year in RegistrationConstants.minYear...(year - RegistrationConstants.minAge) {
            years.append(year)
        }
        
        return years.reversed()
    }
    
    private func getMonths() -> [String] {
        var months = [String]()
        let dateFormatter = DateFormatter()
        for month in 0...11 {
            months.append(dateFormatter.monthSymbols[month])
        }
        return months
    }
    
    override func updateData() {
        self.months = getMonths()
        onSelectedDate?(day, months[month - 1], year)
    }
    
    override func stopUpdate() {
        onSelectedDate = nil
    }
    
    override func title(for row: Int, component: Int?) -> String {
        switch component {
        case Column.first:
            return "\(days[row])"
        case Column.second:
            return months[row]
        case Column.third:
            return "\(years[row])"
        default:
            return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let title = self.title(for: row, component: component)
        
        guard let reusingLabel = view as? UILabel else {
            let label = UILabel.init()
            label.attributedText = NSAttributedString(string: title)
            label.textAlignment = .center
            return label
        }
        
        reusingLabel.attributedText = NSAttributedString(string: title)
        
        return reusingLabel
    }
    
    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case Column.first:
            return days.count
        case Column.second:
            return months.count
        case Column.third:
            return years.count
        default:
            return 0
        }
    }
    
    override func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
        let day = self.picker.selectedRow(inComponent: Column.first) + 1
        let month = self.picker.selectedRow(inComponent: Column.second) + 1
        let year = years[self.picker.selectedRow(inComponent: Column.third)]
        
        onSelectedDate?(day, months[month - 1], year)
        
        self.day = day
        self.month = month
        self.year = year
    }
    
    override func dismiss() {
        if selectedRow == nil {
            onSelectedDate?(1, months[0], years[0])
        }
        
        self.parentVC?.view.endEditing(true)
    }
    
    private struct Column {
        static let first = 0
        static let second = 1
        static let third = 2
    }
}


struct RegistrationConstants {
    static let minAge = 18
    static let minAgeForCasino = 21
    static let minYear = 1901
}
