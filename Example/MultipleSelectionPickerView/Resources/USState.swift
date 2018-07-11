//
//  USStates.swift
//  freighthaul
//
//  Created by Hayk Brsoyan on 6/26/18.
//  Copyright © 2018 Hayk Brsoyan. All rights reserved.
//

import Foundation
import SwiftyJSON
import MultiPickerView

class USState: NSObject {
    
    static let shared = USState()
    
    lazy var states: [State] = {
        let states = JSON(USState.stateJson()).arrayValue.map { State.init(json: $0) }
        return states
    }()
    
    func long() -> [String] {
        let lng = 1   //LanguagesProvider().currentLanguage()
        
        var arr = [String]()
        states.forEach { state in
            if let name = state.names[lng] {
                arr.append(name)
            }
        }
        
        return arr
    }
    
    func short() -> [String] {
        return states.map { $0.abbr }
    }
    
    // data mocked from map/states
    // No need to get this at the runtime
    
    static func stateJson() -> JSON {
        if let path = Bundle.main.path(forResource: "USStates", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                return jsonObj
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        return JSON()
    }
}

extension USState: PickerData {
    func id(for row: Int) -> Int {
        return states[row].id
    }
    
    func long(for row: Int) -> String {
        return long()[row]
    }
    
    func short(for row: Int) -> String {
        return states[row].abbr
    }
    
    func count() -> Int {
        return states.count
    }
}
