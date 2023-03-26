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
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var percentageLabel: UILabel = {
        let label = UILabel()
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
    
    func configure(holerite: HoleriteInfo) {
        titleLabel.text = holerite.title
        
        if holerite.value > 0 {
            valueLabel.text = holerite.value.toCurrencyString()
            let color = holerite.type == .summation ?
            UIColor(red: 0.257, green: 0.65, blue: 0.249, alpha: 1) : UIColor(red: 0.858, green: 0.26, blue: 0.222, alpha: 1)
            
            valueLabel.textColor = color
        } else {
            let quote = "R$ 0,00"
            let font = UIFont.systemFont(ofSize: 14)
            let attributes = [NSAttributedString.Key.font: font]
            let attributedQuote = NSAttributedString(string: quote, attributes: attributes)
            valueLabel.attributedText = attributedQuote
        }
        
        if let percentage = holerite.percentage {
            percentageLabel.text = percentage
            percentageLabel.textColor = UIColor(red: 0.558, green: 0.558, blue: 0.558, alpha: 1)
        } else {
            percentageLabel.removeFromSuperview()
        }
    }
}
