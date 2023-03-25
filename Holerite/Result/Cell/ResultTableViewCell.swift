//
//  ResultTableViewCell.swift
//  Holerite
//
//  Created by Joao Matheus on 25/03/23.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    static let identifier = "ResultTableViewCell"

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Salario bruto"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.text = "R$ 2000,00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "8%"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(percentageLabel)
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setUpConstraint() {
        contentView.addSubview(stackView)
        contentView.addSubview(valueLabel)
        
        [
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ].forEach { constraint in
            constraint.isActive = true
        }
    }
}
