import Cocoa

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var mainWindow: NSWindowController!

    private enum Constants {
        static let mainSceneID = NSStoryboard.SceneIdentifier("MainWindow")
    }

    func start() {
        // Show main window
        showMainUI()
    }

    private func showMainUI() {
        let storyboard = getMainStoryboard()
        mainWindow = storyboard.instantiateController(withIdentifier: Constants.mainSceneID) as! NSWindowController
        mainWindow.window?.center()
        mainWindow.window?.makeKeyAndOrderFront(nil)
    }

}
