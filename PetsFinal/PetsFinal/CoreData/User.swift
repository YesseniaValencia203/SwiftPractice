import Foundation
import CoreData

public class User: NSManagedObject {
    @NSManaged var id: Int16
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var email: String
    @NSManaged var avatar: String
    
    
}
