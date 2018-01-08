import Foundation

struct LoginResponse: Codable {
    let name: String
    let shortName: String
    let email: String
    let timeZone: String
    let lang: String
    let token: String

    enum CodingKeys: String, CodingKey {
        case name
        case shortName = "short_name"
        case email
        case timeZone = "timezone"
        case lang
        case token
    }
}
