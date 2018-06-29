//
//  SelectionView.swift
//  freighthaul
//
//  Created by Hayk Brsoyan on 6/27/18.
//  Copyright © 2018 Hayk Brsoyan. All rights reserved.
//

import UIKit

class SelectionView: UIView {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    enum SelectionViewType {
        case selected
        case deSelected
    }
    
    var type: SelectionViewType = SelectionViewType.deSelected {
        didSet {
            if type == .deSelected {
                imgView?.isHidden = true
            } else {
                imgView?.isHidden = false
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit() {
        let view = loadNib()
        view.frame = bounds
        view.backgroundColor = .clear
        addSubview(view)
    }
    
    func config(type: SelectionViewType, text: String) {
        self.type = type
        self.titleLabel?.text = text
    }
    
    func select() -> Bool {
        if type == .selected {
            type = .deSelected
            return false
        } else {
            type = .selected
            return true
        }
    }
}

