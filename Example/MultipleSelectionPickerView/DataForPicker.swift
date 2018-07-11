//
//  DataForPicker.swift
//  MultipleSelectionPickerView
//
//  Created by Hayk Brsoyan on 7/9/18.
//  Copyright © 2018 Hayk Brsoyan. All rights reserved.
//

import Foundation
import MultiPickerView


class DataForPicker: PickerData {
    private let data: [[String: Any]] = [["id": 0, "longName" : "ALL", "shortName": "ALL"],
                                         ["id": 1, "longName" : "Name 1", "shortName": "NA-1"],
                                         ["id": 2, "longName" : "Name 2", "shortName": "NA-2"],
                                         ["id": 3, "longName" : "Name 3", "shortName": "NA-3"]]
    
    func id(for row: Int) -> Int {
        return data[row]["id"] as! Int
    }
    
    func long(for row: Int) -> String {
        return data[row]["longName"] as! String
    }
    
    func short(for row: Int) -> String {
        return data[row]["shortName"] as! String
    }
    
    func count() -> Int {
        return data.count
    }
}

