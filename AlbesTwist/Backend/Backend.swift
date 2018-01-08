import Foundation

typealias ResponseHandler<T> = (Result<T, Error>) -> Void

protocol Backend {
    func login(email: String, password: String, completion: @escaping ResponseHandler<LoginResponse>)
    func search(query: String, token: String, completion: @escaping ResponseHandler<SearchResponse>)
}
