//
//  ViewController.swift
//  Holerite
//
//  Created by Joao Matheus on 24/03/23.
//

import UIKit

class MainViewController: UIViewController {

    lazy var salaryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Salário bruto"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 2
        return textField
    }()

    lazy var discountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Descontos"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "Roboto-Regular", size: 16)
        return textField
    }()

    lazy var calculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("CALCULAR", for: .normal)
        button.backgroundColor = UIColor(red: 0.31, green: 0.652, blue: 0.967, alpha: 1)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didPressCalculate), for: .touchUpInside)
        return button
    }()

    private var amount: Int = 0
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel = MainViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Holerite"
        setUpBackgroundsColors()
        setUpConstraint()
        viewModel.delegate = self
    }
    
    @objc func didPressCalculate() {
        let viewController = ResultViewController()
        navigationController?.present(viewController, animated: true)
    }

    private func setUpBackgroundsColors() {
        navigationController?.navigationBar.backgroundColor = .white
        view.backgroundColor = UIColor.mainBackgroundColor()
    }
    
    private func setUpConstraint() {
        view.addSubview(salaryTextField)
        view.addSubview(discountTextField)
        view.addSubview(calculateButton)
        
        [
            salaryTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 137),
            salaryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            salaryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            salaryTextField.heightAnchor.constraint(equalToConstant: 44),
            
            discountTextField.topAnchor.constraint(equalTo: salaryTextField.bottomAnchor, constant: 14),
            discountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            discountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            discountTextField.heightAnchor.constraint(equalToConstant: 44),
            
            calculateButton.topAnchor.constraint(equalTo: discountTextField.bottomAnchor, constant: 22),
            calculateButton.widthAnchor.constraint(equalToConstant: 150),
            calculateButton.heightAnchor.constraint(equalToConstant: 50),
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ].forEach { constraint in
            constraint.isActive = true
        }
    }
}

extension MainViewController: MainViewModelDelegate {
    func mainViewModelDelegate(updateAmount text: String, type: AmountType) {
        switch type {
        case .salary:
            salaryTextField.text = text
        case .discount:
            discountTextField.text = text
        }
    }
}

extension MainViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let type = textField.tag == 2 ? AmountType.salary : AmountType.discount
        viewModel.updateAmount(string: string, type: type)
        return false
    }

}

protocol MainViewModelDelegate: AnyObject {
    func mainViewModelDelegate(updateAmount text: String, type: AmountType)
}

enum AmountType {
    case salary
    case discount
}

class MainViewModel {
    private var amountSalary: Int = 0
    private var amountDiscount: Int = 0
    
    weak var delegate: MainViewModelDelegate?
    
    func updateAmount(string: String, type: AmountType) {
        var amountHandler = type == .discount ? amountDiscount : amountSalary
        if amountHandler >= 999999999 { return }
        let action: () -> Void = {
            type == .discount ? updateDiscount() : updateSalary()
        }
        if let digit = Int(string) {
            amountHandler = amountHandler * 10 + digit
            action()
        }
        if string == "" {
            amountHandler = amountHandler/10
            action()
        }

        func updateDiscount() {
            if let amount = updateAmountValue(amount: amountDiscount) {
                amountDiscount = amountHandler
                delegate?.mainViewModelDelegate(updateAmount: amount, type: type)
            }
        }

        func updateSalary() {
            if let amount = updateAmountValue(amount: amountSalary) {
                amountSalary = amountHandler
                delegate?.mainViewModelDelegate(updateAmount: amount, type: type)
            }
        }
    }

    private func updateAmountValue(amount: Int) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        let amount = Double(amount/100) + Double(amount%100)/100
        return formatter.string(from: NSNumber(value: amount))
    }
}
