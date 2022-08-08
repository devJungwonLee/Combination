//
//  RecordListViewModel.swift
//  Combination
//
//  Created by 이정원 on 2022/08/02.
//

import Foundation

final class RecordListViewModel: ObservableObject {
    @Published private var recordListUseCase = RecordListUseCase()
    @Published var shouldShowAlert = false
    @Published var isEditing = false
    @Published var selectedRows = Set<Date>()
    @Published var criterion: Criterion = .date
    @Published var isAscending = false
    
    var presentedRecords: [RecordViewModel] {
        recordListUseCase.sortedRecords(criterion, isAscending)
            .map { RecordViewModel(record: $0) }
    }
    
    var isAllSelected: Bool {
        selectedRows == Set(presentedRecords.map { $0.id })
    }
    
    func viewDidAppear() {
        recordListUseCase.fetchAllRecords()
    }
    
    func selectAllButtonDidTap() {
        if isAllSelected {
            selectedRows.removeAll()
        } else {
            selectedRows = Set(presentedRecords.map { $0.id })
        }
    }
    
    func oneRowDeleteEventDidAppear(_ index: Int?) {
        guard let index = index else { return }
        var row = Set<Date>()
        row.insert(presentedRecords[index].id)
        recordListUseCase.delete(row)
    }
    
    func editButtonDidTap() {
        selectedRows.removeAll()
        isEditing.toggle()
    }
    
    func deleteButtonDidTap() {
        if !selectedRows.isEmpty {
            shouldShowAlert = true
        }
    }
    
    func alertDeleteButtonDidTap() {
        recordListUseCase.delete(selectedRows)
        isEditing = false
    }
}

struct RecordViewModel {
    private let record: Record
    
    init(record: Record) {
        self.record = record
    }
    
    var id: Date {
        record.date
    }
    
    var date: String {
        record.date.formattedString
    }
    
    var elapsedTime: String {
        record.elapsedSeconds.timeFormattedString
    }
    
    var score: String {
        "\(record.score)"
    }
    
    var numberOfAnswer: String {
        "\(record.numberOfAnswer)"
    }
    
    var trialCount: String {
        "\(record.trialCount)"
    }
    
    var hintCount: String {
        "\(record.hintCount)"
    }
}
