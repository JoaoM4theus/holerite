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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBackgroundColor()
        setUpConstraint()
    }

    @objc func close() {
        print("close")
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
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell",
                                                       for: indexPath) as? ResultTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
