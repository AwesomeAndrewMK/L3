//
//  MainViewController.swift
//  L3
//
//  Created by Andrii Kuznietsov on 04.12.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private enum Const {
        static let padding: CGFloat = 24
    }
    
    private var cardTextField = CardTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewContoller()
        createDismissKeyboardTapGesture()
        configureLayout()
    }
    
    private func configureViewContoller() {
        view.backgroundColor = .systemBackground
        view.addSubview(cardTextField)
    }
    
    private func configureLayout() {
        cardTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.padding),
            cardTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Const.padding),
        ])
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}

#Preview {
    return MainViewController()
}
