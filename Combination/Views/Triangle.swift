//
//  Triangle.swift
//  Combination
//
//  Created by 이정원 on 2022/06/07.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let length = max(rect.width, rect.height) / sqrt(3)

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX - length, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + length, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}
