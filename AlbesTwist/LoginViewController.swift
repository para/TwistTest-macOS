import Cocoa

protocol LoginViewControllerDelegate: class {
    func didLogin(_ loginViewController: LoginViewController)
}

class LoginViewController: NSViewController {
    weak var delegate: LoginViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = NSSize(width: 400.0, height: 200.0)
    }

    @IBAction func loginButtonPushed(_ sender: Any) {
        delegate?.didLogin(self)
    }

}

