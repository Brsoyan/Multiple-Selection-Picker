//
//  State.swift
//  MultipleSelectionPickerView
//
//  Created by Hayk Brsoyan on 7/9/18.
//  Copyright © 2018 Hayk Brsoyan. All rights reserved.
//

import Foundation
import SwiftyJSON


struct State {
    var id: Int = 0
    var names: [Int: String]
    var abbr: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.names = [Int:String]()
        self.abbr = json["abbr"].stringValue
        
        for name in json["names"] {
            if let id: Int = Int(name.0) {
                self.names[id] = name.1.stringValue
            }
        }
    }
}

private var stateList: [AnyHashable: State] = [AnyHashable: State]()

var StateList: [AnyHashable: State] {
    get {
        if(stateList.count <= 0) {
            let json = JSON(USState.stateJson())
            stateList = json.arrayValue.map {
                State(json: $0)
                }.reduce(into: [AnyHashable: State]()) { dict, state in
                    dict[state.id] = state
                    dict[state.abbr] = state
            }
        }
        return stateList
    }
}
