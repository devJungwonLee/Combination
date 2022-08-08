//
//  Extension+Int.swift
//  Combination
//
//  Created by 이정원 on 2022/08/01.
//

import Foundation

extension Int {
    var timeFormattedString: String {
        let hour = String(format: "%02d", self/3600)
        let minute = String(format: "%02d", self%3600/60)
        let second = String(format: "%02d", self%60)
        return "\(hour) : \(minute) : \(second)"
    }
}
