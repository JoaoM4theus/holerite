//
//  ResultViewController.swift
//  Holerite
//
//  Created by Joao Matheus on 25/03/23.
//

import UIKit

class ResultViewController: UIViewController {

    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("FECHAR", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.mainBackgroundColor()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ResultTableViewCell.self,
                           forCellReuseIdentifier: ResultTableViewCell.identifier)
        return tableView
    }()
    
    let viewModel: ResultViewModel
    
    init(viewModel: ResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBackgroundColor()
        setUpConstraint()
    }

    @objc func close() {
        presentingViewController?.dismiss(animated: true)
    }
    
    private func setUpConstraint() {
        view.addSubview(closeButton)
        view.addSubview(tableView)
        
        [
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 22),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            closeButton.widthAnchor.constraint(equalToConstant: 70),
            closeButton.heightAnchor.constraint(equalToConstant: 18),
            
            tableView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 22),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].forEach { constraint in
            constraint.isActive = true
        }
    }
}

extension ResultViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell",
                                                       for: indexPath) as? ResultTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(holerite: viewModel.model[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
