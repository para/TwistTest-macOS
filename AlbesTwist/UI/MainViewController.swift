import Cocoa

class MainViewController: NSViewController {

    private enum Constants {
        static let resultCellID = NSUserInterfaceItemIdentifier("ResultItem")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension MainViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 0
    }

    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
}

extension MainViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: Constants.resultCellID, owner: nil) as! ResultItemCell
        return cell
    }
}

// MARK: - MainView methods, used by the presenter

protocol MainView: class {
    func showLoading()
    func hideLoading()
    func refreshResults()
    func showSearchError(errorText: String)
}
