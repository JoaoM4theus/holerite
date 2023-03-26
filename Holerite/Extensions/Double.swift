//
//  Double.swift
//  Holerite
//
//  Created by Joao Matheus on 26/03/23.
//

import Foundation

extension Double {
    func toCurrencyString() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        return formatter.string(from: NSNumber(value: self))
    }
}
