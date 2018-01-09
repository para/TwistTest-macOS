import Foundation

class MockDataSource: DataSource {
    var loggedUser: LoggedUser?
    var searchResults: SearchResults?

    func getLoggedUser() -> LoggedUser? {
        return loggedUser
    }

    func saveLoggedUser(_ user: LoggedUser) {
        self.loggedUser = user
    }

    func deleteLoggedUser() {
        self.loggedUser = nil
    }

    func getSearchResults() -> SearchResults? {
        return searchResults
    }

    func saveSearchResults(_ results: SearchResults) {
        self.searchResults = results
    }

    func deleteSearchResults() {
        self.searchResults = nil
    }
}
