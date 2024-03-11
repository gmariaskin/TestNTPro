//
//  DealModel.swift
//  TemplateOfDealsViewer
//
//  Created by Gleb on 12.03.2024.
//

import Foundation

struct Deal {
    let id: Int64
    let dateModifier: Date
    let instrumentName: String
    let price: Double
    let amount: Double
    let side: Side
    
    enum Side: CaseIterable, Comparable {
        case sell, buy
    }
    
}
