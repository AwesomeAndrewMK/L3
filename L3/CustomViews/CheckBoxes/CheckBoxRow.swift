//
//  CheckBoxRow.swift
//  L3
//
//  Created by Andrii Kuznietsov on 22.12.2023.
//

import UIKit

class CheckBoxRow: UIView {
    
    private enum Const {
        static let defaultLabelSize: CGFloat = 17
        static let defaultCheckboxSize: CGFloat = 30
    }
    
    private lazy var checkboxButton: UIButton = {
        let checkboxButton = UIButton()
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        checkboxButton.layer.borderWidth = 2
        checkboxButton.layer.cornerRadius = 5
        checkboxButton.layer.borderColor = UIColor.systemGray.cgColor
        checkboxButton.addTarget(self, action: #selector(onCheckBoxPressed), for: .touchUpInside)
        
        return checkboxButton
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .label
        
        return titleLabel
    }()
    
    private var checkImage: UIImage = .check1
    private var isChecked = false
    private lazy var checkboxHeightAnchor: NSLayoutConstraint = checkboxButton.heightAnchor.constraint(equalToConstant: Const.defaultCheckboxSize)
    private lazy var checkboxWidthAnchor: NSLayoutConstraint = checkboxButton.widthAnchor.constraint(equalToConstant: Const.defaultCheckboxSize)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(title: String, font: UIFont.TextStyle = .body, size: CGFloat = Const.defaultLabelSize) {
        self.init(frame: .zero)
        self.titleLabel.text = title
        self.titleLabel.font = UIFont.preferredFont(forTextStyle: font)
        self.titleLabel.font = UIFont.systemFont(ofSize: size)
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        addSubview(checkboxButton)
        addSubview(titleLabel)
        
        checkboxHeightAnchor.isActive = true
        checkboxWidthAnchor.isActive = true
        
        NSLayoutConstraint.activate([
            checkboxButton.topAnchor.constraint(equalTo: topAnchor),
            checkboxButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            checkboxButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: checkboxButton.centerYAnchor)
        ])
    }
    
    @objc private func onCheckBoxPressed() {
        isChecked.toggle()
        checkboxButton.setImage(isChecked ? checkImage : nil, for: .normal)
    }
    
    func changeCheckImage(to image: UIImage) {
        checkImage = image
    }
    
    func getIsChecked() -> Bool {
        return isChecked
    }
    
    func setCheckboxSize(size: CGFloat) {
        checkboxHeightAnchor.constant = size
        checkboxWidthAnchor.constant = size
    }
}

//MARK: - #Preview

#Preview {
    MainViewController()
}
