import Cocoa

protocol LoginCoordinatorDelegate: class {
    func coordinatorDidLogin(_ coordinator: LoginCoordinator)
}

class LoginCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    private var windowController: NSWindowController
    weak var delegate: LoginCoordinatorDelegate?

    private enum Constants {
        static let loginSceneID = NSStoryboard.SceneIdentifier("LoginController")
    }

    init(windowController: NSWindowController) {
        self.windowController = windowController
    }

    func start() {
        let storyboard = getMainStoryboard()
        let loginVC = storyboard.instantiateController(withIdentifier: Constants.loginSceneID) as! LoginViewController
        loginVC.delegate = self
        windowController.contentViewController?
            .presentViewControllerAsSheet(loginVC)
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    func didLogin(_ loginViewController: LoginViewController) {
        loginViewController.dismiss(nil)
        delegate?.coordinatorDidLogin(self)
    }
}

