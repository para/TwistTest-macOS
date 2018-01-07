import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var params: [String: String]? { get }
    var headers: [String: String]? { get }
}
