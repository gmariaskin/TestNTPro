//
//  Double .swift
//  TemplateOfDealsViewer
//
//  Created by Gleb on 08.03.2024.
//

import Foundation

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
