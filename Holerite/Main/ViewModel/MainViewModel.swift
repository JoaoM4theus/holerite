//
//  MainViewModel.swift
//  Holerite
//
//  Created by Joao Matheus on 25/03/23.
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    func mainViewModel(pushViewController info: [HoleriteInfo])
}

class MainViewModel {
    
    weak var delegate: MainViewModelDelegate?
    var holerite = [HoleriteInfo]()
    
    func calculate(salary: Double, discount: Double) {
        holerite.removeAll()
        var salaryWithDiscount = salary - discount
        holerite.append(HoleriteInfo(value: salary, title: "Salário Bruto", type: .summation))
        holerite.append(HoleriteInfo(value: discount, title: "Descontos", type: .discount))
        
        let inss = calculateINSS(salary: salary)
        salaryWithDiscount -= inss.value
        holerite.append(HoleriteInfo(value: inss.value, title: "Desconto INSS", percentage: inss.percentage, type: .discount))
        
        let irrf = calculateIRRF(salary: salaryWithDiscount + discount)
        salaryWithDiscount -= irrf.value
        holerite.append(HoleriteInfo(value: irrf.value, title: "Desconto IRRF", percentage: irrf.percentage, type: .discount))
        
        holerite.append(HoleriteInfo(value: salaryWithDiscount, title: "Salário Líquido", type: .summation))
        delegate?.mainViewModel(pushViewController: holerite)
    }

    private func calculateINSS(salary: Double) -> (percentage: String?, value: Double) {
        if salary <= 1212 {
            return ("7.5%", salary * (7.5/100))
        }
        let discountOne = (7.5/100) * 1212
        if salary >= 1212.01 && salary <= 2427.35 {
            let discountTwo = (9/100) * (salary - 1212.01)
            return ("9%", (discountOne + discountTwo))
        }
        let discountTwo = (9/100) * (2427.35 - 1212.01)
        if salary >= 2427.36 && salary <= 3641.03 {
            let discountThree = (12/100) * (salary - 2427.36)
            return ("12%", (discountOne + discountTwo + discountThree))
        }
        let discountThree = (12/100) * (3641.03 - 2427.36)
        if salary >= 3641.04 && salary <= 7087.22 {
            let discountFour = (14/100) * (salary - 3641.04)
            return ("14%", (discountOne + discountTwo + discountThree + discountFour))
        }
        
        return (nil, 828.39)
    }
    
    func calculateIRRF(salary: Double) -> (percentage: String?, value: Double) {
        if salary <= 1903.98 {
            return ("0%", .zero)
        }
        if salary >= 1903.99 && salary <= 2826.65 {
            var value = salary * (7.5/100)
            value -= 142.80
            return ("7.5%",value)
        }
        if salary >= 2826.66 && salary <= 3751.05 {
            var value = salary * (15/100)
            value -= 354.8
            return ("15%",value)
        }
        if salary >= 3751.06 && salary <= 4664.68 {
            var value = salary * (22.5/100)
            value -= 636.13
            return ("22.5%",value)
        }
        var value = salary * (27.5/100)
        value -= 869.36
        return ("27.5%",value)
    }
}

struct HoleriteInfo {
    let value: Double
    let title: String
    let percentage: String?
    let type: TypeInfo
    
    init(value: Double, title: String, percentage: String? = nil, type: TypeInfo) {
        self.value = value
        self.title = title
        self.percentage = percentage
        self.type = type
    }
}

enum TypeInfo {
    case summation
    case discount
}
