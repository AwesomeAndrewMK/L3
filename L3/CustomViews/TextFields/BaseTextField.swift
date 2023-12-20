//
//  BaseTextField.swift
//  L3
//
//  Created by Andrii Kuznietsov on 05.12.2023.
//

import UIKit

class BaseTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
        placeholder = Constants.textFieldPlaceholder
        keyboardType = .numberPad
    }
}
