//
//  Card.swift
//  Combination
//
//  Created by 이정원 on 2022/06/11.
//

import Foundation

struct Card: Identifiable, Equatable {
    enum Shape: CaseIterable {
        case circle, triangle, square
    }

    enum ShapeColor: CaseIterable {
        case red, blue, yellow
    }

    enum BackgroundColor: CaseIterable {
        case black, gray, white
    }
    
    var id: Int
    let shape: Shape
    let shapeColor: ShapeColor
    let backgroundColor: BackgroundColor
    var isSelected = false
}
