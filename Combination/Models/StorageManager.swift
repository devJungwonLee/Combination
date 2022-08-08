//
//  StorageManager.swift
//  Combination
//
//  Created by 이정원 on 2022/08/01.
//

import Foundation
import CoreData

final class StorageManager {
    let persistentContainer: NSPersistentContainer
    static let shared = StorageManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "RecordModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("\(error)")
            }
        }
    }
    
    func fetchAllRecords() -> [RecordModel] {
        do {
            return try viewContext.fetch(RecordModel.fetchRequest())
        } catch {
            return []
        }
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            fatalError("\(error.localizedDescription)")
        }
    }
    
    func delete(_ id: Date) {
        guard let recordModel = getRecord(by: id) else { return }
        viewContext.delete(recordModel)
        save()
    }
    
    private func getRecord(by id: Date) -> RecordModel? {
        do {
            let fetchRequest = RecordModel.fetchRequest()
            fetchRequest.predicate = .init(format: "date = %@", id as CVarArg)
            return try viewContext.fetch(fetchRequest).first
        } catch {
            fatalError("\(error.localizedDescription)")
        }
    }
}
