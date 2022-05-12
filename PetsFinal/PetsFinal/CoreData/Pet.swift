import Foundation
import CoreData


public class Pet: NSManagedObject {
    @NSManaged var ownerID: Int16
    @NSManaged var id: Int16
    @NSManaged var species: String
    @NSManaged var name: String
    @NSManaged var gender: String
    @NSManaged var age: String
}
