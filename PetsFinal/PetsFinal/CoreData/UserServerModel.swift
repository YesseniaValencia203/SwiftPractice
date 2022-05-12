import Foundation
struct UserServerModel: Codable {
    let avatar: String
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys:String, CodingKey {
        case avatar = "avatar"
        case id = "id"
        case email = "email"
        case firstName = "first_name"
        case lastName = "last_name"
    }
    static let database = DatabaseHandler.shared
    func store() {
        guard let user = UserServerModel.database.add(User.self) else { return }
        user.avatar = avatar
        user.email = email
        user.firstName = firstName
        user.lastName = lastName
        user.id = Int16(id)
        UserServerModel.database.save()
    }
}
