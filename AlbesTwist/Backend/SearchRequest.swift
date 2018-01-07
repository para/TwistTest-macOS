import Foundation

enum SearchRequest: Request {
    case search(query: String, token: String)

    var path: String {
        let searchPath = "search"
        switch self {
        case .search:
            return "\(searchPath)/query"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }

    var params: [String: String]? {
        switch self {
        case .search(let query, _):
            return ["query": query]
        }
    }

    var headers: [String: String]? {
        switch self {
        case .search(_, let token):
            return ["Authorization": "Bearer \(token)"]
        }
    }
}
