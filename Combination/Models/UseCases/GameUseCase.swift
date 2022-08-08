//
//  GameUseCase.swift
//  Combination
//
//  Created by 이정원 on 2022/07/20.
//

import Foundation

struct GameUseCase {
    private let allCards: [Card] = createAllCards()
    private(set) var cards: [Card] = []
    private var answer: Set<Set<Int>> = []
    private(set) var userAnswer: [Set<Int>] = []
    private var selectedIndices: Set<Int> = []
    private(set) var hint: [Card]?
    
    private(set) var round = 0
    private(set) var score = 0
    private(set) var elapsedSeconds = 0
    private(set) var numberOfAnswer = 0
    private(set) var trialCount = 0
    private(set) var hintCount = 0
    private(set) var feedback: Feedback?
    private(set) var isGameOver = false
    
    var didFindAllSets: Bool {
        answer.isEmpty
    }
    
    static private func createAllCards() -> [Card] {
        var allCards = [Card]()
        for shapeColor in Card.ShapeColor.allCases {
            for shape in Card.Shape.allCases {
                for backgroundColor in Card.BackgroundColor.allCases {
                    allCards.append(
                        Card(
                            id: 0,
                            shape: shape,
                            shapeColor: shapeColor,
                            backgroundColor: backgroundColor
                        )
                    )
                }
            }
        }
        return allCards
    }
    
    mutating func start() {
        round = 0
        elapsedSeconds = 0
        score = 0
        isGameOver = false
        startRound()
    }
    
    private mutating func startRound() {
        round += 1
        cards.removeAll()
        answer.removeAll()
        userAnswer.removeAll()
        selectedIndices.removeAll()
        chooseCards()
        findAnswers()
    }
    
    private mutating func chooseCards() {
        var allCards = allCards
        cards.removeAll()
        (0..<9).forEach { index in
            guard let randomIndex = allCards.indices.randomElement() else { return }
            var card = allCards[randomIndex]
            card.id = index
            cards.append(card)
            allCards.remove(at: randomIndex)
        }
    }
    
    private mutating func findAnswers() {
        for first in 0..<9 {
            for second in (first+1)..<9 {
                for third in (second+1)..<9 {
                    let cardSet = [first, second, third]
                    if isCorrect(cardSet) { answer.insert(Set(cardSet)) }
                }
            }
        }
        numberOfAnswer += answer.count
    }
    
    private func isCorrect(_ cardSet: [Int]) -> Bool {
        let shapes = cardSet.map { cards[$0].shape }
        let shapeColors = cardSet.map { cards[$0].shapeColor }
        let backgroundColors = cardSet.map { cards[$0].backgroundColor }
        return shapes.areElementsAllTheSameOrAllDifferent && shapeColors.areElementsAllTheSameOrAllDifferent && backgroundColors.areElementsAllTheSameOrAllDifferent
    }
    
    mutating func tap(_ card: Card) -> Bool {
        guard let index = cards.firstIndex(of: card) else { return false }
        if card.isSelected {
            selectedIndices.remove(index)
        } else {
            selectedIndices.insert(index)
        }
        cards[index].isSelected.toggle()
        
        if selectedIndices.count == 3 {
            clearHint()
            trialCount += 1
            if answer.contains(selectedIndices) {
                answer.remove(selectedIndices)
                userAnswer.append(selectedIndices)
                feedback = .correct
                score += Feedback.correct.point
            } else if userAnswer.contains(selectedIndices) {
                feedback = .alreadyDone
                score += Feedback.alreadyDone.point
            } else {
                feedback = .notCorrect
                score += Feedback.notCorrect.point
            }
            return true
        }
        return false
    }
    
    mutating func resetSelection() {
        selectedIndices.forEach { index in
            cards[index].isSelected.toggle()
        }
        selectedIndices.removeAll()
    }
    
    mutating func finishRound() -> Bool {
        resetSelection()
        clearHint()
        trialCount += 1
        if didFindAllSets {
            feedback = .finished
            score += Feedback.finished.point
            if round < 10 {
                startRound()
            } else {
                isGameOver = true
                return true
            }
        } else {
            feedback = .notFinished
            score += Feedback.notFinished.point
        }
        return false
    }
    
    mutating func addSecond() {
        elapsedSeconds += 1
    }
    
    mutating func clearFeedback() {
        feedback = nil
    }
    
    mutating func clearHint() {
        hint = nil
    }
    
    mutating func findHint() {
        clearFeedback()
        score -= 1
        hintCount += 1
        if let indices = answer.randomElement() {
            var temp = Array(indices).map { cards[$0] }
            temp.removeLast()
            temp[0].isSelected = false
            temp[1].isSelected = false
            hint = temp
        } else {
            hint = []
        }
    }
}
