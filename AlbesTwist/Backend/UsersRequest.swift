import Foundation

enum UsersRequest: Request {
    case login(email: String, password: String)

    var path: String {
        let usersPath = "users"
        switch self {
        case .login:
            return "\(usersPath)/login"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }

    var params: [String: String]? {
        switch self {
        case .login(let email, let password):
            return ["email": email, "password": password]
        }
    }

    var headers: [String: String]? {
        switch self {
        case .login:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        }
    }
}
