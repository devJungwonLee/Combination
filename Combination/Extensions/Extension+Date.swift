//
//  Extension+Date.swift
//  Combination
//
//  Created by 이정원 on 2022/08/02.
//

import Foundation

extension Date {
    var formattedString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy년 M월 d일     a h시 m분"
        return dateFormatter.string(from: self)
    }
}
