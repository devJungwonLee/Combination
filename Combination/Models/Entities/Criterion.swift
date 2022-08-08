//
//  Criterion.swift
//  Combination
//
//  Created by 이정원 on 2022/08/03.
//

import Foundation

enum Criterion: String, Equatable, CaseIterable {
    case date = "날짜"
    case score = "점수"
    case elapsedTime = "시간"
    
    var name: String {
        self.rawValue
    }
}
