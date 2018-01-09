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
    }

    func configure(cell: ResultItemCell, forRow row: Int) {
        guard let searchResults = searchResults, row > 0 && row < searchResults.items.count else {
            return
        }

        let item = searchResults.items[row]
        cell.titleLabel.stringValue = item.title
        cell.contentsLabel.stringValue = item.contents
        cell.dateLabel.stringValue = formatter.string(from: item.ts)
    }

    func doSearch(query: String) {
        
    }

}
