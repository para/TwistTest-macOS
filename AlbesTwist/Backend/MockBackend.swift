import Foundation

class MockBackend: Backend {
    var expectedResults = 0

    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        let response = LoginResponse(name: "name", shortName: "shortName", email: "email", timeZone: "timeZone", lang: "lang", token: "token")
        completion(.success(response))
    }

    func search(query: String, token: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        var items = [SearchResponseItem]()
        for i in 0 ..< expectedResults {
            let item = SearchResponseItem(title: "title\(i)", snippet: "snippet\(i)", ts: Date().timeIntervalSince1970, lastAuthor: i, channelId: i)
            items.append(item)
        }
        let response = SearchResponse(hits: expectedResults, items: items)
        completion(.success(response))
    }
}
