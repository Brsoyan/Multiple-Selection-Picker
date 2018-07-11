//
//  MultipleSelectionPickerScrollHelper.swift
//  freighthaul
//
//  Created by Hayk Brsoyan on 7/7/18.
//  Copyright © 2018 Hayk Brsoyan. All rights reserved.
//

import UIKit

protocol MultipleSelectionPickerScrollDelegate: class {
    func select()
}

class MultipleSelectionPickerScrollHelper: NSObject, UIGestureRecognizerDelegate {
    
    weak var delegate: MultipleSelectionPickerScrollDelegate?
    weak var owner: MultipleSelectionPickerViewHandler?
    private var shouldRecognizeSimultaneously = 0
    private var isSelectInRow = false
    
    init(owner: MultipleSelectionPickerViewHandler) {
        self.owner = owner
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if otherGestureRecognizer is UITapGestureRecognizer && gestureRecognizer is UITapGestureRecognizer {
            shouldRecognizeSimultaneously = 0

            if owner?.isSelectInRow(gestureRecognizer: otherGestureRecognizer) == true {
                isSelectInRow = true
            }
        }
        
        return false
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {

        if otherGestureRecognizer is UITapGestureRecognizer && shouldRecognizeSimultaneously == 0 && isSelectInRow == true {
            delegate?.select()
        }

        isSelectInRow = false
        shouldRecognizeSimultaneously += 1

        return false
    }
}
