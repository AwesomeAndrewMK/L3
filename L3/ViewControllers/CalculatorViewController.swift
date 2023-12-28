//
//  CalculatorViewController.swift
//  L3
//
//  Created by Andrii Kuznietsov on 28.12.2023.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    private let resultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.addSubview(resultLabel)
        view.backgroundColor = .systemBackground
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.text = "Calculator"
        
        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
