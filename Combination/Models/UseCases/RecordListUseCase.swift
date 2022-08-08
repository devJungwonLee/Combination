//
//  RecordListUseCase.swift
//  Combination
//
//  Created by 이정원 on 2022/08/02.
//

import Foundation

struct RecordListUseCase {
    private(set) var records: [Record] = []
    
    mutating func fetchAllRecords() {
        records = StorageManager.shared.fetchAllRecords().map { recordModel in
            Record(
                date: recordModel.date ?? Date(),
                elapsedSeconds: Int(recordModel.elapsedSeconds),
                score: Int(recordModel.score),
                numberOfAnswer: Int(recordModel.numberOfAnswer),
                trialCount: Int(recordModel.trialCount),
                hintCount: Int(recordModel.hintCount)
            )
        }
    }
    
    func sortedRecords(_ criterion: Criterion, _ isAscending: Bool) -> [Record] {
        return records.sorted { lhs, rhs in
            switch criterion {
            case .date:
                return isAscending ? lhs.date < rhs.date : lhs.date > rhs.date
            case .score:
                return isAscending ? lhs.score < rhs.score : lhs.score > rhs.score
            case .elapsedTime:
                return isAscending ? lhs.elapsedSeconds < rhs.elapsedSeconds : lhs.elapsedSeconds > rhs.elapsedSeconds
            }
        }
    }
    
    mutating func delete(_ ids: Set<Date>) {
        for id in ids {
            StorageManager.shared.delete(id)
        }
        fetchAllRecords()
    }
}
