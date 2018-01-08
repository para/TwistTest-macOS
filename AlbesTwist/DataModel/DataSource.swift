import Foundation

protocol DataSource {
    func getLoggedUser() -> LoggedUser?
    func saveLoggedUser(_ user: LoggedUser)
    func deleteLoggedUser()
    func getSearchResults() -> SearchResults?
    func saveSearchResults(_ results: SearchResults)
    func deleteSearchResults()
}
