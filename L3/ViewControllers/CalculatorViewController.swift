//
//  CalculatorViewController.swift
//  L3
//
//  Created by Andrii Kuznietsov on 28.12.2023.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    private let resultLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.textColor = .white
        resultLabel.textAlignment = .right
        resultLabel.font = .systemFont(ofSize: 40)
        resultLabel.text = "0"
        
        return resultLabel
    }()
    private let mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 1
        
        return mainStackView
    }()
    lazy var resultLabelContainer = createRowStackView()
    lazy var firstButtonsRow = createRowStackView()
    lazy var secondButtonsRow = createRowStackView()
    lazy var thirdButtonsRow = createRowStackView()
    lazy var fourthButtonsRow = createRowStackView()
    lazy var fifthButtonsRow = createRowStackView()
    lazy var fifthButtonsRowLeftHalf = createRowStackView()
    lazy var fifthButtonsRowRightHalf = createRowStackView()
    
    // landscape buttons
    lazy var sinButton = createCalcButton(symbol: "sin", backgroundColor: .darkGray)
    lazy var cosButton = createCalcButton(symbol: "cos", backgroundColor: .darkGray)
    lazy var tanButton = createCalcButton(symbol: "tan", backgroundColor: .darkGray)
    lazy var logButton = createCalcButton(symbol: "log", backgroundColor: .darkGray)
    lazy var inButton = createCalcButton(symbol: "In", backgroundColor: .darkGray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setOrienationLayout()
    }
    
    private func configure() {
        view.addSubview(mainStackView)
        view.backgroundColor = .black
        
        mainStackView.addArrangedSubview(resultLabelContainer)
        resultLabelContainer.addSubview(resultLabel)
        
        mainStackView.addArrangedSubview(firstButtonsRow)
        firstButtonsRow.addArrangedSubview(createCalcButton(symbol: "AC", backgroundColor: .darkGray))
        firstButtonsRow.addArrangedSubview(createCalcButton(symbol: "+/-", backgroundColor: .darkGray))
        firstButtonsRow.addArrangedSubview(createCalcButton(symbol: "%", backgroundColor: .darkGray))
        firstButtonsRow.addArrangedSubview(createCalcButton(symbol: "÷", backgroundColor: .orange))
        
        mainStackView.addArrangedSubview(secondButtonsRow)
        secondButtonsRow.addArrangedSubview(createCalcButton(symbol: "7", backgroundColor: .darkGray))
        secondButtonsRow.addArrangedSubview(createCalcButton(symbol: "8", backgroundColor: .darkGray))
        secondButtonsRow.addArrangedSubview(createCalcButton(symbol: "9", backgroundColor: .darkGray))
        secondButtonsRow.addArrangedSubview(createCalcButton(symbol: "×", backgroundColor: .orange))
        
        mainStackView.addArrangedSubview(thirdButtonsRow)
        thirdButtonsRow.addArrangedSubview(createCalcButton(symbol: "4", backgroundColor: .darkGray))
        thirdButtonsRow.addArrangedSubview(createCalcButton(symbol: "5", backgroundColor: .darkGray))
        thirdButtonsRow.addArrangedSubview(createCalcButton(symbol: "6", backgroundColor: .darkGray))
        thirdButtonsRow.addArrangedSubview(createCalcButton(symbol: "-", backgroundColor: .orange))
        
        mainStackView.addArrangedSubview(fourthButtonsRow)
        fourthButtonsRow.addArrangedSubview(createCalcButton(symbol: "1", backgroundColor: .darkGray))
        fourthButtonsRow.addArrangedSubview(createCalcButton(symbol: "2", backgroundColor: .darkGray))
        fourthButtonsRow.addArrangedSubview(createCalcButton(symbol: "3", backgroundColor: .darkGray))
        fourthButtonsRow.addArrangedSubview(createCalcButton(symbol: "+", backgroundColor: .orange))
        
        mainStackView.addArrangedSubview(fifthButtonsRow)
        fifthButtonsRow.addArrangedSubview(fifthButtonsRowLeftHalf)
        fifthButtonsRowLeftHalf.addArrangedSubview(createCalcButton(symbol: "0", backgroundColor: .darkGray))
        fifthButtonsRow.addArrangedSubview(fifthButtonsRowRightHalf)
        fifthButtonsRowRightHalf.addArrangedSubview(createCalcButton(symbol: ".", backgroundColor: .darkGray))
        fifthButtonsRowRightHalf.addArrangedSubview(createCalcButton(symbol: "=", backgroundColor: .orange))
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            resultLabel.centerYAnchor.constraint(equalTo: resultLabelContainer.centerYAnchor),
            resultLabel.leadingAnchor.constraint(equalTo: resultLabelContainer.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: resultLabelContainer.trailingAnchor, constant: -20)
        ])
    }
    
    private func createRowStackView() -> UIStackView {
        let rowStackView = UIStackView()
        rowStackView.translatesAutoresizingMaskIntoConstraints = false
        rowStackView.distribution = .fillEqually
        rowStackView.spacing = 1
        
        return rowStackView
    }
    
    private func createCalcButton(symbol: String, backgroundColor: UIColor) -> UIButton {
        let calcButton = UIButton()
        let font = UIFont.systemFont(ofSize: 40)
        let attrTitle = NSAttributedString(string: symbol, attributes: [NSAttributedString.Key.font: font])
        
        calcButton.backgroundColor = backgroundColor
        calcButton.setTitleColor(.white, for: .normal)
        calcButton.setAttributedTitle(attrTitle, for: .normal)
        calcButton.setTitle(symbol, for: .normal)
        
        return calcButton
    }
    
    private func setOrienationLayout() {
        if UIDevice.current.orientation.isLandscape {
            firstButtonsRow.insertArrangedSubview(sinButton, at: 0)
            secondButtonsRow.insertArrangedSubview(cosButton, at: 0)
            thirdButtonsRow.insertArrangedSubview(tanButton, at: 0)
            fourthButtonsRow.insertArrangedSubview(logButton, at: 0)
            fifthButtonsRow.insertArrangedSubview(inButton, at: 0)
        } else {
            firstButtonsRow.removeArrangedSubview(sinButton)
            secondButtonsRow.removeArrangedSubview(cosButton)
            thirdButtonsRow.removeArrangedSubview(tanButton)
            fourthButtonsRow.removeArrangedSubview(logButton)
            fifthButtonsRow.removeArrangedSubview(inButton)
            
            sinButton.removeFromSuperview()
            cosButton.removeFromSuperview()
            tanButton.removeFromSuperview()
            logButton.removeFromSuperview()
            inButton.removeFromSuperview()
        }
    }
}

//MARK: - #Preview
#Preview {
    CalculatorViewController()
}
