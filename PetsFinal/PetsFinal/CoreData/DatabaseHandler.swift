import Foundation
import CoreData
import UIKit

class DatabaseHandler {
    private let viewContext: NSManagedObjectContext
    static let shared = DatabaseHandler()
    init() {
        viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

    }
    func add<T: NSManagedObject>(_ type: T.Type) -> T? {
        guard let entityName = T.entity().name else { return nil }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: viewContext) else { return nil }
        // we've created name of entity and we want to get description of entity -> should belong to that given viewCOntext so it works in our persistent container ( relation model essentially)
        let object = T(entity: entity, insertInto: viewContext)
        return object
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
        // we're getting all of the records, instead of a single record
        let request = T.fetchRequest()
        do {
            let result = try viewContext.fetch(request)
            return (result as! [T])
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func save() {
        // try to save if we can, else throw the error
        viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        do {
            try viewContext.save()
        }  catch {
            print(error.localizedDescription)
        }
    }
    func delete<T: NSManagedObject>(_ object: T) {
        viewContext.delete(object)
        // need to save
        save()
    }
    
}


