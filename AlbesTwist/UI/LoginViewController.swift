import Cocoa

protocol LoginViewControllerDelegate: class {
    func didLogin(_ loginViewController: LoginViewController)
}

class LoginViewController: NSViewController {
    var presenter: LoginPresenter!
    weak var delegate: LoginViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = NSSize(width: 400.0, height: 200.0)

        presenter.attach(loginView: self)
    }

    @IBAction func loginButtonPushed(_ sender: Any) {
        presenter.doLogin(email: "", password: "")
    }

}

// MARK: - LoginView methods, used by the presenter

protocol LoginView: class {
    func showLoading()
    func hideLoading()
    func showLoginSuccess()
    func showLoginError()
}

extension LoginViewController: LoginView {
    func showLoading() {

    }

    func hideLoading() {
        
    }

    func showLoginSuccess() {
        delegate?.didLogin(self)
    }

    func showLoginError() {

    }
}

