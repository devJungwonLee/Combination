//
//  GameResultViewModel.swift
//  Combination
//
//  Created by 이정원 on 2022/08/01.
//

import Foundation

final class GameResultViewModel: ObservableObject {
    @Published private var gameResultUseCase: GameResultUseCase
    
    init(record: Record) {
        gameResultUseCase = GameResultUseCase(record: record)
    }
    
    var elapsedTime: String {
        gameResultUseCase.record.elapsedSeconds.timeFormattedString
    }
    
    var score: String {
        "\(gameResultUseCase.record.score)"
    }
    
    func viewDidAppear() {
        gameResultUseCase.saveRecord()
    }
}
