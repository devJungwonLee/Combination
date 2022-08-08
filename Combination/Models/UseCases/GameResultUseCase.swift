//
//  GameResultUseCase.swift
//  Combination
//
//  Created by 이정원 on 2022/08/01.
//

import Foundation

struct GameResultUseCase {
    let record: Record
    
    init(record: Record) {
        self.record = record
    }
    
    func saveRecord() {
        let recordModel = RecordModel(context: StorageManager.shared.viewContext)
        recordModel.date = record.date
        recordModel.elapsedSeconds = Int64(record.elapsedSeconds)
        recordModel.score = Int64(record.score)
        recordModel.numberOfAnswer = Int64(record.numberOfAnswer)
        recordModel.trialCount = Int64(record.trialCount)
        recordModel.hintCount = Int64(record.hintCount)
        StorageManager.shared.save()
    }
}
