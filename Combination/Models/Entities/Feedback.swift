//
//  Feedback.swift
//  Combination
//
//  Created by 이정원 on 2022/07/29.
//

import Foundation

enum Feedback {
    case correct, notCorrect, finished, notFinished, alreadyDone
    
    var point: Int {
        switch self {
        case .correct:
            return 1
        case .notCorrect:
            return -1
        case .finished:
            return 3
        case .notFinished:
            return -1
        case .alreadyDone:
            return -1
        }
    }
}
