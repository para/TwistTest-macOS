import Cocoa

class MainViewController: NSViewController, Spinnable {
    @IBOutlet var spinner: NSProgressIndicator!
    @IBOutlet var searchField: NSSearchField!
    @IBOutlet var tableView: NSTableView!
    @IBOutlet var loggedUserLabel: NSTextField!

    var presenter: MainPresenter!

    private enum Constants {
        static let resultCellID = NSUserInterfaceItemIdentifier("ResultItem")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        spinner.isHidden = true

        presenter.attach(mainView: self)
        presenter.preloadMainView()
    }

    func didLogin() {
        presenter.preloadMainView()
    }

    @IBAction func didStartSearch(_ sender: Any) {
        presenter.doSearch(query: searchField.stringValue)
    }
}

extension MainViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return presenter.itemCount
    }

    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
}

extension MainViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: Constants.resultCellID, owner: nil) as! ResultItemCell

        self.presenter.configure(cell: cell, forRow: row)

        return cell
    }
}

// MARK: - MainView methods, used by the presenter

protocol MainView: class {
    func showLoading()
    func hideLoading()
    func showQuery(text: String)
    func showResults()
    func showSearchError(errorText: String)
    func showLoggedUser(name: String)
}

extension MainViewController: MainView {

    func showLoading() {
        startSpinning()
    }

    func hideLoading() {
        stopSpinning()
    }

    func showQuery(text: String) {
        DispatchQueue.main.async {
            self.searchField.stringValue = text
        }
    }

    func showResults() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showSearchError(errorText: String) {
        let alert = NSAlert()
        alert.alertStyle = .warning
        alert.messageText = "Search Error"
        alert.informativeText = errorText
        alert.addButton(withTitle: "OK")

        DispatchQueue.main.async {
            alert.runModal()
        }
    }

    func showLoggedUser(name: String) {
        DispatchQueue.main.async {
            self.loggedUserLabel.stringValue = name
        }
    }
}
