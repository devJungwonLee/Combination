//
//  Extension+Array.swift
//  Combination
//
//  Created by 이정원 on 2022/07/24.
//

import Foundation

extension Array where Element: Equatable {
    var areElementsAllTheSameOrAllDifferent: Bool {
        return (self[0] == self[1] && self[1] == self[2]) || (self[0] != self[1] && self[1] != self[2] && self[2] != self[0])
    }
}
