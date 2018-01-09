import Cocoa

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    private var mainWindow: NSWindowController!
    private var dataSource = CoreDataDataSource()

    private enum Constants {
        static let mainSceneID = NSStoryboard.SceneIdentifier("MainWindow")
    }

    func start() {
        // Show main window
        showMainUI()

        // Present login view if necessary
        if !isLoggedIn() {
            showLogin()
        }
    }

    private func showMainUI() {
        let storyboard = getMainStoryboard()
        mainWindow = storyboard.instantiateController(withIdentifier: Constants.mainSceneID) as! NSWindowController
        mainWindow.window?.contentMinSize = NSSize(width: 420.0, height: 220.0)
        mainWindow.window?.center()
        mainWindow.window?.makeKeyAndOrderFront(nil)
    }

    private func showLogin() {
        let loginCoordinator = LoginCoordinator(windowController: mainWindow)
        loginCoordinator.delegate = self
        addChild(coordinator: loginCoordinator)
        loginCoordinator.start()
    }

    private func isLoggedIn() -> Bool {
        return dataSource.getLoggedUser() != nil
    }

}

extension MainCoordinator: LoginCoordinatorDelegate {
    func coordinatorDidLogin(_ coordinator: LoginCoordinator) {
        removeChild(coordinator: coordinator)
    }
}
