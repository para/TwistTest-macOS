import XCTest
@testable import AlbesTwist

class MainViewPresenterTests: XCTestCase {

    let dataSource = MockDataSource()
    let backend = MockBackend()
    
    override func setUp() {
        super.setUp()

        // Seed DB
        dataSource.saveLoggedUser(LoggedUser(name: "Mock User", timeZone: "Italy/Rome", token: "token"))
        let resultItem = ResultItem(title: "title", contents: "contents", ts: Date())
        let items = [resultItem]
        let results = SearchResults(query: "query", ts: Date(), items: items)
        dataSource.saveSearchResults(results)
    }
    
    override func tearDown() {
        super.tearDown()
        // Clear DB
        dataSource.deleteLoggedUser()
        dataSource.deleteSearchResults()
    }

    func testConfigureCell() {
        let presenter = MainViewPresenter(dataSource: dataSource, backend: backend)

        let mainVC = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("MainController")) as! MainViewController
        mainVC.presenter = presenter
        mainVC.loadView()
        let cell = mainVC.tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("ResultItem"), owner: nil) as! ResultItemCell

        let row = 0

        presenter.configure(cell: cell, forRow: row)

        let searchResults = dataSource.getSearchResults()!

        XCTAssertEqual(cell.titleLabel.stringValue, searchResults.items[row].title)
        XCTAssertEqual(cell.contentsLabel.stringValue, searchResults.items[row].contents)
        XCTAssertEqual(cell.dateLabel.stringValue, presenter.formatter.string(from: searchResults.items[row].ts))
    }

    func testSearch() {
        let presenter = MainViewPresenter(dataSource: dataSource, backend: backend)

        dataSource.deleteSearchResults()
        let resultCount = 3
        backend.expectedResults = 3
        let query = "This is my query"

        presenter.doSearch(query: query)

        let searchResults = dataSource.getSearchResults()
        XCTAssertNotNil(searchResults)
        XCTAssertEqual(searchResults!.query, query)
        XCTAssertEqual(searchResults!.items.count, resultCount)
    }
    
}
