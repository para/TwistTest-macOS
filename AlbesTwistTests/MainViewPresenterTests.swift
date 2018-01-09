import XCTest
@testable import AlbesTwist

class MainViewPresenterTests: XCTestCase {

    let dataSource = MockDataSource()
    
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
        let presenter = MainViewPresenter(dataSource: dataSource, backend: StagingBackend())

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
    
}
