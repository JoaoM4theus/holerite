//
//  CustomTextField.swift
//  Holerite
//
//  Created by Joao Matheus on 25/03/23.
//

import UIKit

class CustomTextField: UITextField {
    
    private var amount: Int = .zero
    var formattedValue: Double = .zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateAmount(string: String) {
        if let digit = Int(string) {
            if amount <= 999_999_999 {
                amount = amount * 10 + digit
            }
            self.text = updateAmount()
        }
        
        if string == "" {
            amount = amount/10
            self.text = updateAmount()
        }
    }
    
    private func updateAmount() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formattedValue = Double(amount/100) + Double(amount%100)/100
        return formatter.string(from: NSNumber(value: formattedValue))
    }

}
