import Cocoa

protocol LoginViewControllerDelegate: class {
    func didLogin(_ loginViewController: LoginViewController)
}

class LoginViewController: NSViewController {
    @IBOutlet var emailField: NSTextField!
    @IBOutlet var passwordField: NSTextField!
    @IBOutlet var spinner: NSProgressIndicator!

    var presenter: LoginPresenter!
    weak var delegate: LoginViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = NSSize(width: 400.0, height: 200.0)
        spinner.isHidden = true

        presenter.attach(loginView: self)
    }

    @IBAction func loginButtonPushed(_ sender: Any) {
        presenter.doLogin(email: emailField.stringValue, password: passwordField.stringValue)
    }

}

// MARK: - LoginView methods, used by the presenter

protocol LoginView: class {
    func showLoading()
    func hideLoading()
    func showLoginSuccess()
    func showLoginError(errorText: String)
}

extension LoginViewController: LoginView {
    func showLoading() {
        DispatchQueue.main.async {
            self.spinner.isHidden = false
            self.spinner.startAnimation(self)
        }
    }

    func hideLoading() {
        DispatchQueue.main.async {
            self.spinner.isHidden = true
            self.spinner.stopAnimation(self)
        }
    }

    func showLoginSuccess() {
        delegate?.didLogin(self)
    }

    func showLoginError(errorText: String) {
        let alert = NSAlert()
        alert.alertStyle = .warning
        alert.messageText = "Login Error"
        alert.informativeText = errorText
        alert.addButton(withTitle: "OK")

        DispatchQueue.main.async {
            alert.runModal()
        }
    }
}

