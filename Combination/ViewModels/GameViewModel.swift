//
//  GameViewModel.swift
//  Combination
//
//  Created by 이정원 on 2022/07/22.
//

import Foundation

final class GameViewModel: ObservableObject {
    @Published private var gameUseCase = GameUseCase()
    @Published private(set) var isGamePaused = false
    @Published var shouldShowAlert = false
    private var timer = Timer()
    
    var playOrPauseButtonTitle: String {
        isGamePaused ? "다시시작" : "일시정지"
    }
    
    var round: String {
        "\(gameUseCase.round) 라운드"
    }
    
    var score: String {
        "\(gameUseCase.score)"
    }
    
    var cards: [Card] {
        gameUseCase.cards
    }
    
    var shouldShowMessage: Bool {
        get { gameUseCase.feedback != nil }
        set { gameUseCase.clearFeedback() }
    }
    
    var shouldPush: Bool {
        get { gameUseCase.isGameOver }
        set { }
    }
    
    var message: String {
        guard let feedback = gameUseCase.feedback else { return "" }
        var message = ""
        switch feedback {
        case .correct:
            message = "합!"
        case .notCorrect:
            message = "합이 아닙니다."
        case .finished:
            message = "결!"
        case .notFinished:
            message = "결이 아닙니다."
        case .alreadyDone:
            message = "이미 찾은 합입니다."
        }
        message += " " + (feedback.point > 0 ? "+" : "") + "\(feedback.point)점"
        return message
    }
    
    var shouldShowHint: Bool {
        get { gameUseCase.hint != nil }
        set { gameUseCase.clearHint() }
    }
    
    var hint: [Card] {
        gameUseCase.hint ?? []
    }
    
    var elapsedTime: String {
        gameUseCase.elapsedSeconds.timeFormattedString
    }
    
    var userAnswer: [String] {
        var answer = gameUseCase.userAnswer.map { cardSet in
            return Array(cardSet).sorted().map { String($0 + 1) }.joined(separator: "  ")
        }
        while answer.count < 12 { answer.append(" ") }
        return answer
    }
    
    var record: Record {
        Record(
            date: Date(),
            elapsedSeconds: gameUseCase.elapsedSeconds,
            score: gameUseCase.score,
            numberOfAnswer: gameUseCase.numberOfAnswer,
            trialCount: gameUseCase.trialCount,
            hintCount: gameUseCase.hintCount
        )
    }
    
    func viewDidAppear() {
        gameUseCase.start()
        startTimer()
    }
    
    func cardDidTap(_ card: Card) {
        if gameUseCase.tap(card) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                self?.gameUseCase.resetSelection()
            }
        }
    }
    
    func hintButtonDidTap() {
        gameUseCase.findHint()
    }
    
    func finishButtonDidTap() {
        if gameUseCase.finishRound() {
            timer.invalidate()
        }
    }
    
    func exitButtonDidTap() {
        if !isGamePaused {
            playOrPause()
        }
        shouldShowAlert.toggle()
    }
    
    func alertExitButtonDidTap() {
        endTimer()
    }
    
    func playOrPauseButtonDidTap() {
        playOrPause()
    }
    
    func willResignActive() {
        if !isGamePaused {
            playOrPause()
        }
    }
    
    private func startTimer() {
        isGamePaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
            self?.gameUseCase.addSecond()
        })
    }
    
    private func endTimer() {
        isGamePaused = true
        timer.invalidate()
    }
    
    private func playOrPause() {
        if isGamePaused {
            startTimer()
        } else {
            endTimer()
        }
    }
}
