//
//  ViewController.swift
//  Holerite
//
//  Created by Joao Matheus on 24/03/23.
//

import UIKit

class MainViewController: UIViewController {

    lazy var salaryTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Salário bruto"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.delegate = self
        textField.font = UIFont(name: "Roboto-Regular", size: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 2
        return textField
    }()

    lazy var discountTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Descontos"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.delegate = self
        textField.font = UIFont(name: "Roboto-Regular", size: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
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

    private let viewModel: MainViewModel
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        viewModel = MainViewModel()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Holerite"
        viewModel.delegate = self
        setUpNavBar()
        setUpBackgroundsColors()
        setUpConstraint()
    }
    
    func setUpNavBar() {
        let navBar = self.navigationController!.navigationBar

        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()

        navBar.standardAppearance = standardAppearance
        navBar.scrollEdgeAppearance = standardAppearance
    }
    
    @objc func didPressCalculate() {
        if salaryTextField.formattedValue > 0 && discountTextField.formattedValue >= 0 {
            viewModel.calculate(salary: salaryTextField.formattedValue, discount: discountTextField.formattedValue)
        } else {
            dontOpenAlert()
        }
    }

    private func dontOpenAlert() {
        let alert = UIAlertController(title: "Salário bruto indevido",
                                      message: "Adicione um salário bruto maior que 0, por favor.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
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

extension MainViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let textField = textField as? CustomTextField {
            textField.updateAmount(string: string)
        }
        return false
    }

}

extension MainViewController: MainViewModelDelegate {
    func mainViewModel(pushViewController info: [HoleriteInfo]) {
        let viewModel = ResultViewModel(model: info)
        let viewController = ResultViewController(viewModel: viewModel)
        navigationController?.present(viewController, animated: true)
    }
    
    
}
