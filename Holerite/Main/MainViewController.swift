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
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    lazy var discountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Descontos"
        textField.borderStyle = .roundedRect
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

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Holerite"
        setUpBackgroundsColors()
        setUpConstraint()
    }
    
    @objc func didPressCalculate() {
        let viewController = ResultViewController()
        navigationController?.present(viewController, animated: true)
    }

    func setUpBackgroundsColors() {
        navigationController?.navigationBar.backgroundColor = .white
        view.backgroundColor = UIColor(red: 0.938, green: 0.938, blue: 0.938, alpha: 1)
    }
    
    func setUpConstraint() {
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

