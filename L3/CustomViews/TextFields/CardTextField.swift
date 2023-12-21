//
//  CardTextField.swift
//  L3
//
//  Created by Andrii Kuznietsov on 12.12.2023.
//

import UIKit

class CardTextField: UIView {
    
    enum TextFieldComponents {
        case border, underline, counter, switcher, placehonder, title, text
    }
    
    private enum Const {
        static let padding: CGFloat = 10
        static let textFieldTopPadding: CGFloat = 15
        static let textFieldHeight: CGFloat = 24
        static let switcherRightPadding: CGFloat = 12
        static let bottomBorderTopPadding: CGFloat = 2
        static let counterLabelTopPadding: CGFloat = 5
        static let titleLabelTopPadding: CGFloat = -7
    }
    
    private var defaultTextColor: UIColor = .black
    private var defaultBorderColor: UIColor = .lightGray
    private var defaultUnderlineColor: UIColor = .green
    private var defaultCounterColor: UIColor = .black
    private var defaultSwitcherColor: UIColor = .green
    private var defaultPlacehonderColor: UIColor = .lightGray
    private var defaultTitleColor: UIColor = .lightGray
    
    private var counterLabel = UILabel()
    private var bottomBorder = UIView()
    
    private lazy var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.addTarget(self, action: #selector(switcherValueChanged), for: .valueChanged)
        switcher.translatesAutoresizingMaskIntoConstraints = false
        
        return switcher
    }()
    
    lazy var textField: BaseTextField = {
        let textField = BaseTextField()
        textField.delegate = self
        
        return textField
    }()
    
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = " Card number "
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.isHidden = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    private var errorMessage: UILabel = {
        let errorMessage = UILabel()
        errorMessage.text = "Card number should be 16 digits long."
        errorMessage.textColor = .red
        errorMessage.font = UIFont.systemFont(ofSize: 14)
        errorMessage.isHidden = true
        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        
        return errorMessage
    }()
    
    private var textFieldBorderColor: UIColor = UIColor.lightGray {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private lazy var bottomBorderHeightConstraintBold: NSLayoutConstraint = bottomBorder.heightAnchor.constraint(equalToConstant: 2)
    private lazy var bottomBorderHeightConstraintLight: NSLayoutConstraint = bottomBorder.heightAnchor.constraint(equalToConstant: 1)
    private lazy var errorMessageHeightAnchor: NSLayoutConstraint = errorMessage.heightAnchor.constraint(equalToConstant: 0)
    static let layoutMargins: NSDirectionalEdgeInsets = .init(top: 0, leading: Const.padding, bottom: 0, trailing: Const.padding)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureLayout()
        configureToolBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        textFieldBorderColor.set()
        UIBezierPath(roundedRect: CGRectInset(self.bounds, 0.5, 0.5), cornerRadius: 10).stroke()
    }
    
    func autoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func onChangeComponentColour(for item: TextFieldComponents, with color: UIColor) {
        switch item {
        case .border:
            textFieldBorderColor = color
            defaultBorderColor = color
        case .counter:
            counterLabel.textColor = color
            defaultCounterColor = color
        case .underline:
            bottomBorder.backgroundColor = color
            defaultBorderColor = color
        case .switcher:
            switcher.onTintColor = color
            defaultSwitcherColor = color
        case .placehonder:
            let attributedPlaceholder = NSAttributedString(string: Constants.textFieldPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: color])
            textField.attributedPlaceholder = attributedPlaceholder
            defaultPlacehonderColor = color
        case .title:
            titleLabel.textColor = color
            defaultTitleColor = color
        case .text:
            textField.textColor = color
            defaultTextColor = color
        }
    }
    
    private func configure() {
        addSubview(textField)
        addSubview(bottomBorder)
        addSubview(counterLabel)
        addSubview(errorMessage)
        addSubview(titleLabel)
        
        directionalLayoutMargins = CardTextField.layoutMargins
        
        backgroundColor = .systemBackground
        titleLabel.backgroundColor = .systemBackground
        bottomBorder.backgroundColor = .systemGreen
        counterLabel.text = "Count: 0"
        counterLabel.font = UIFont.systemFont(ofSize: 12)
        textField.leftView = switcher
        textField.leftViewMode = .always
    }
    
    private func configureLayout() {
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        
        bottomBorderHeightConstraintLight.isActive = true
        errorMessageHeightAnchor.isActive = true
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: Const.textFieldTopPadding),
            textField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: Const.textFieldHeight),
            
            bottomBorder.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: switcher.frame.width + Const.switcherRightPadding),
            bottomBorder.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            bottomBorder.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Const.bottomBorderTopPadding),
            
            counterLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Const.counterLabelTopPadding),
            counterLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            
            errorMessage.topAnchor.constraint(equalTo: counterLabel.bottomAnchor),
            errorMessage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Const.padding),
            errorMessage.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            errorMessage.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            switcher.widthAnchor.constraint(equalToConstant: switcher.frame.width + Const.padding),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Const.titleLabelTopPadding),
            titleLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor)
        ])
    }
    
    @objc private func switcherValueChanged() {
        textField.isSecureTextEntry = switcher.isOn
        textField.placeholder = switcher.isOn ? Constants.textFieldPlaceholderSecure : Constants.textFieldPlaceholder
    }
    
    private func showValidationError() {
        textFieldBorderColor = .red
        errorMessage.isHidden = false
        textField.textColor = .red
        counterLabel.textColor = .red
        titleLabel.textColor = .red
        bottomBorder.backgroundColor = .red
        
        errorMessageHeightAnchor.isActive = false
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
    }
    
    private func hideValidationError() {
        textFieldBorderColor = defaultBorderColor
        textField.textColor = defaultTextColor
        counterLabel.textColor = defaultCounterColor
        titleLabel.textColor = defaultTitleColor
        bottomBorder.backgroundColor = defaultUnderlineColor
        errorMessage.isHidden = true
        
        errorMessageHeightAnchor.isActive = true
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
    }
}

//MARK: - UIToolbar configuration

extension CardTextField {
    private func configureToolBar() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 44.0)))
        toolbar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(keyboardCancelEditing))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let addButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(keyboardEndEditing))
        
        toolbar.setItems([cancelButton, flexibleSpace, addButton], animated: false)
        textField.inputAccessoryView = toolbar
    }
    
    @objc private func keyboardEndEditing(sender: UIBarButtonItem) {
        endEditing(true)
    }
    
    @objc private func keyboardCancelEditing(sender: UIBarButtonItem) {
        textField.text = ""
        endEditing(true)
    }
}

//MARK: - UITextFieldDelegate

extension CardTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 16
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        return newText.count <= maxLength
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        titleLabel.isHidden = false
        textField.placeholder = ""
        hideValidationError()
        
        bottomBorderHeightConstraintLight.isActive = false
        bottomBorderHeightConstraintBold.isActive = true
        
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let enteredText = textField.text else { return }
        
        if enteredText.count != 16 && !enteredText.isEmpty {
            showValidationError()
        }
        
        if enteredText.isEmpty {
            textField.placeholder = "Card number"
            titleLabel.isHidden = true
        }
        
        bottomBorderHeightConstraintBold.isActive = false
        bottomBorderHeightConstraintLight.isActive = true
        
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        counterLabel.text = "Count: \(textField.text?.count ?? 0)"
    }
}

//MARK: - #Preview

#Preview {
    CardTextField()
}
