
import Foundation

struct UserAccount {
    let username: String
    let password: String
}

struct ValidationService {
    func validateUserName(_ username: String?) throws -> String {
        guard let username = username else { throw ValidationError.invalidEntry }
        guard username.count > 3 else { throw ValidationError.usernameTooShort }
        guard username.count < 10 else { throw ValidationError.usernameTooLong }
        return username
    }
    
    func validatePassword(_ password: String?) throws ->  String {
        guard let password = password else { throw ValidationError.invalidEntry }
        guard password.count > 5 else { throw ValidationError.passwordTooShort }
        guard password.count < 12 else { throw ValidationError.passwordTooLong }
        
        return password
    }
    
}
enum ValidationError: LocalizedError {
    case invalidEntry
    case usernameTooShort
    case usernameTooLong
    case passwordTooShort
    case passwordTooLong
}
