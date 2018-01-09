import Cocoa

class MainViewController: NSViewController, Spinnable {
    @IBOutlet var spinner: NSProgressIndicator!
    @IBOutlet var tableView: NSTableView!

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
        return cell
    }
}

// MARK: - MainView methods, used by the presenter

protocol MainView: class {
    func showLoading()
    func hideLoading()
    func showResults()
    func showSearchError(errorText: String)
}

extension MainViewController: MainView {

    func showLoading() {
        startSpinning()
    }

    func hideLoading() {
        stopSpinning()
    }

    func showResults() {
        tableView.reloadData()
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
}
