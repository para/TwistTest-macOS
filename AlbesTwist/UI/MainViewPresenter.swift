import Foundation

protocol MainPresenter {
    var itemCount: Int { get }

    init(dataSource: DataSource, backend: Backend)

    func attach(mainView: MainView)
    func preloadMainView()
    func configure(cell: ResultItemCell, forRow row: Int)
    func doSearch(query: String)
}

class MainViewPresenter: MainPresenter {
    private let dataSource: DataSource
    private let backend: Backend
    private weak var mainView: MainView?

    private var searchResults: SearchResults?
    private var loggedUser: LoggedUser?

    private let formatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        return df
    }()

    var itemCount: Int {
        return searchResults?.items.count ?? 0
    }

    required init(dataSource: DataSource, backend: Backend) {
        self.dataSource = dataSource
        self.backend = backend

        self.searchResults = dataSource.getSearchResults()
    }

    func attach(mainView: MainView) {
        self.mainView = mainView
    }

    func preloadMainView() {
        mainView?.showResults()

        if let lastQuery = searchResults?.query {
            mainView?.showQuery(text: lastQuery)
        }
    }

    func configure(cell: ResultItemCell, forRow row: Int) {
        guard let searchResults = searchResults, row >= 0 && row < searchResults.items.count else {
            return
        }

        let item = searchResults.items[row]
        cell.titleLabel.stringValue = item.title
        cell.contentsLabel.stringValue = item.contents
        cell.dateLabel.stringValue = formatter.string(from: item.ts)
    }

    func doSearch(query: String) {
        // Ignore empty queries
        guard query.count > 0 else {
            return
        }

        if loggedUser == nil {
            loggedUser = dataSource.getLoggedUser()
            if loggedUser == nil {
                mainView?.showSearchError(errorText: "Please login before searching.")
                return
            }
        }

        mainView?.showLoading()

        backend.search(query: query, token: loggedUser!.token) { [weak self] result in
            self?.mainView?.hideLoading()

            if result.isSuccess {
                let searchResponse = result.value!
                var items = [ResultItem]()
                for responseItem in searchResponse.items {
                    items.append(ResultItem(title: responseItem.title, contents: responseItem.snippet, ts: Date(timeIntervalSince1970: responseItem.ts)))
                }
                let searchResults = SearchResults(query: query, ts: Date(), items: items)
                self?.searchResults = searchResults
                self?.dataSource.saveSearchResults(searchResults)

                self?.mainView?.showResults()
            } else {
                self?.mainView?.showSearchError(errorText: "Search failed, please try again.")
            }
        }
    }

}
