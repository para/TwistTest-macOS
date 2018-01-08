import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum RequestParams {
    case body(_ : [String: String])
    case url(_ : [String: String])
}

protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var params: RequestParams? { get }
    var headers: [String: String]? { get }
}
