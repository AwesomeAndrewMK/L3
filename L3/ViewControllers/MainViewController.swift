//
//  MainViewController.swift
//  L3
//
//  Created by Andrii Kuznietsov on 22.12.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private enum Const {
        static let horizontalPadding: CGFloat = 16
    }
    
    private let checkBox: CheckBoxRow = {
        let checkBox = CheckBoxRow(title: "Some test text for a CheckBox")
        return checkBox
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        view.addSubview(checkBox)
        
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkBox.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            checkBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.horizontalPadding),
            checkBox.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Const.horizontalPadding)
        ])
    }
}
