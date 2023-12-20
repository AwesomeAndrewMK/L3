//
//  CardTextField.swift
//  L3
//
//  Created by Andrii Kuznietsov on 12.12.2023.
//

import UIKit

enum TextFieldComponents {
    case border, underline, counter, switcher, placehonder, title, text
}

class CardTextField: UIView {
    
    enum Const {
        static let padding: CGFloat = 10
    }
    
    // colors
    private var defaultTextColor: UIColor = .black
    private var defaultBorderColor: UIColor = .lightGray
    private var defaultUnderlineColor: UIColor = .green
    private var defaultCounterColor: UIColor = .black
    private var defaultSwitcherColor: UIColor = .green
    private var defaultPlacehonderColor: UIColor = .lightGray
    private var defaultTitleColor: UIColor = .lightGray
    
    var textField = BaseTextField()
    private var counter = UILabel()
    private var bottomBorder = UIView()
    private var switcher = UISwitch()
    private var bottomBorderHeightConstraintBold: NSLayoutConstraint?
    private var bottomBorderHeightConstraintLight: NSLayoutConstraint?
    private var errorMessageHeightAnchor: NSLayoutConstraint?
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = " Card number "
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.isHidden = true
        
        return titleLabel
    }()
    private var errorMessage: UILabel = {
        let errorMessage = UILabel()
        errorMessage.text = "Card number should be 16 digits long."
        errorMessage.textColor = .red
        errorMessage.font = UIFont.systemFont(ofSize: 14)
        errorMessage.isHidden = true
        
        return errorMessage
    }()
    private var textFieldBorderColor: UIColor = UIColor.lightGray {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textField.delegate = self
        configureView()
        configureUI()
        configureLayout()
        switcherSetup()
        configureToolBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        textFieldBorderColor.set()
        UIBezierPath(roundedRect: CGRectInset(self.bounds, 0.5, 0.5), cornerRadius: 10).stroke()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
        
        titleLabel.backgroundColor = .systemBackground
        
        addSubview(textField)
        addSubview(bottomBorder)
        addSubview(counter)
        addSubview(errorMessage)
        addSubview(titleLabel)
    }
    
    private func configureUI() {
        bottomBorder.backgroundColor = .systemGreen
        
        counter.text = "Count: 0"
        counter.font = UIFont.systemFont(ofSize: 12)
        
        textField.leftView = switcher
        textField.leftViewMode = .always
    }
    
    private func switcherSetup() {
        switcher.addTarget(self, action: #selector(switcherValueChanged), for: .valueChanged)
    }
    
    @objc private func switcherValueChanged() {
        if switcher.isOn == true {
            textField.isSecureTextEntry = true
            textField.placeholder = Constants.textFieldPlaceholderSecure
        } else {
            textField.isSecureTextEntry = false
            textField.placeholder = Constants.textFieldPlaceholder
        }
    }
    
    func onChangeComponentColour(for item: TextFieldComponents, with color: UIColor) {
        switch item {
        case .border:
            textFieldBorderColor = color
            defaultBorderColor = color
        case .counter:
            counter.textColor = color
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
    
    private func configureLayout() {
        counter.translatesAutoresizingMaskIntoConstraints = false
        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        
        bottomBorderHeightConstraintLight = bottomBorder.heightAnchor.constraint(equalToConstant: 1)
        bottomBorderHeightConstraintBold = bottomBorder.heightAnchor.constraint(equalToConstant: 2)
        bottomBorderHeightConstraintLight?.isActive = true
        
        errorMessageHeightAnchor = errorMessage.heightAnchor.constraint(equalToConstant: 0)
        errorMessageHeightAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Const.padding),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Const.padding),
            textField.heightAnchor.constraint(equalToConstant: 24),
            
            bottomBorder.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: switcher.frame.width + 12),
            bottomBorder.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            bottomBorder.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 2),
            
            counter.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5),
            counter.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            
            errorMessage.topAnchor.constraint(equalTo: counter.bottomAnchor),
            errorMessage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Const.padding),
            errorMessage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Const.padding),
            errorMessage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Const.padding),
            
            switcher.widthAnchor.constraint(equalToConstant: switcher.frame.width + Const.padding),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: -7),
            titleLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor)
        ])
    }
    
    private func showValidationError() {
        textFieldBorderColor = .red
        errorMessage.isHidden = false
        textField.textColor = .red
        counter.textColor = .red
        titleLabel.textColor = .red
        bottomBorder.backgroundColor = .red
        
        errorMessageHeightAnchor?.isActive = false
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
    }
    
    private func hideValidationError() {
        textFieldBorderColor = defaultBorderColor
        textField.textColor = defaultTextColor
        counter.textColor = defaultCounterColor
        titleLabel.textColor = defaultTitleColor
        bottomBorder.backgroundColor = defaultUnderlineColor
        errorMessage.isHidden = true
        
        errorMessageHeightAnchor?.isActive = true
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
    }
    
    private func configureToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(keyboardCancelEditing))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let addButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(keyboardEndEditing))
        
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
        
        bottomBorderHeightConstraintLight?.isActive = false
        bottomBorderHeightConstraintBold?.isActive = true
        
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let enteredText = textField.text {
            if enteredText.count != 16 && enteredText.count > 0 {
                showValidationError()
            }
            if enteredText.count == 0 {
                textField.placeholder = "Card number"
                titleLabel.isHidden = true
            }
            
            bottomBorderHeightConstraintBold?.isActive = false
            bottomBorderHeightConstraintLight?.isActive = true
            
            UIView.animate(withDuration: 0.1) {
                self.layoutIfNeeded()
            }
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        counter.text = "Count: \(textField.text?.count ?? 0)"
    }
}

#Preview {
    CardTextField()
}
