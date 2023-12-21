//
//  MainViewController.swift
//  L3
//
//  Created by Andrii Kuznietsov on 04.12.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private enum Const {
        static let horizontalPadding: CGFloat = 24
    }
    
    private let cardTextField = CardTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        createDismissKeyboardTapGesture()
        configureLayout()
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        view.addSubview(cardTextField)
    }
    
    private func configureLayout() {
        cardTextField.autoLayout()
        
        NSLayoutConstraint.activate([
            cardTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.horizontalPadding),
            cardTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Const.horizontalPadding)
        ])
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}

//MARK: - #Preview

#Preview {
    return MainViewController()
}
