import Foundation

protocol MainPresenter {
    init(dataSource: DataSource, backend: Backend)
    func attach(mainView: MainView)
}

class MainViewPresenter: MainPresenter {
    private let dataSource: DataSource
    private let backend: Backend
    private weak var mainView: MainView?

    required init(dataSource: DataSource, backend: Backend) {
        self.dataSource = dataSource
        self.backend = backend
    }

    func attach(mainView: MainView) {
        self.mainView = mainView
    }

}
