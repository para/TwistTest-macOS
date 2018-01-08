import Foundation

class StagingBackend: Backend {
    private var session = URLSession(configuration: URLSessionConfiguration.default)

    private enum Constants {
        static let basePath = "https://staging.twistapp.com/api/v2"
    }

    func login(email: String, password: String, completion: @escaping ResponseHandler<LoginResponse>) {
        let loginRequest = UsersRequest.login(email: email, password: password)
        execute(request: loginRequest) { data, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            if let data = data {
                let decoder = JSONDecoder()
                if let loginResponse = try? decoder.decode(LoginResponse.self, from: data) {
                    completion(.success(loginResponse))
                }
            }
        }
    }

    func search(query: String, token: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        let searchRequest = SearchRequest.search(query: query, token: token)
        execute(request: searchRequest) { data, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            if let data = data {
                let decoder = JSONDecoder()
                if let searchResponse = try? decoder.decode(SearchResponse.self, from: data) {
                    completion(.success(searchResponse))
                }
            }
        }
    }
}

// MARK: - Request Parsing & Execution

extension StagingBackend {
    private typealias ExecuteHandler = (Data?, Error?) -> Void

    private func execute(request: Request, completion: @escaping ExecuteHandler) {
        let urlRequest = getUrlRequestFrom(req: request)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            completion(data, error)
        }
        task.resume()
    }

    private func getUrlRequestFrom(req: Request) -> URLRequest {
        let fullPath = "\(Constants.basePath)/\(req.path)"
        var urlRequest = URLRequest(url: URL(string: fullPath)!)

        urlRequest.httpMethod = req.method.rawValue

        if let headers = req.headers {
            headers.forEach { (key, value) in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        if let params = req.params {
            switch params {
            case .body(let paramDict):
                let paramString = paramDict
                    .map { (key, value) in
                        "\(key)=\(value)"
                    }
                    .joined(separator: "&")

                urlRequest.httpBody = paramString.data(using: .utf8, allowLossyConversion: false)
            case .url(let paramDict):
                let queryString = paramDict
                    .map { (key, value) in
                        "\(key)=\(value)"
                    }
                    .joined(separator: "&")
                    .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

                if let queryString = queryString {
                    let fullPathWithQuery = "\(fullPath)?\(queryString)"
                    urlRequest.url = URL(string: fullPathWithQuery)
                }
            }
        }

        return urlRequest
    }
}
