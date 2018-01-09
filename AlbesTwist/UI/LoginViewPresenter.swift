import Foundation

protocol LoginPresenter {
    init(dataSource: DataSource, backend: Backend)
    func attach(loginView: LoginView)
    func doLogin(email: String, password: String)
}

class LoginViewPresenter: LoginPresenter {
    private let dataSource: DataSource
    private let backend: Backend
    private weak var loginView: LoginView?

    required init(dataSource: DataSource, backend: Backend) {
        self.dataSource = dataSource
        self.backend = backend
    }

    func attach(loginView: LoginView) {
        self.loginView = loginView
    }

    func doLogin(email: String, password: String) {
        loginView?.showLoading()
        backend.login(email: email, password: password) { [weak self] result in
            self?.loginView?.hideLoading()

            if result.isSuccess {
                let loginResponse = result.value!
                let loggedUser = LoggedUser(name: loginResponse.name, timeZone: loginResponse.timeZone, token: loginResponse.token)
                self?.dataSource.saveLoggedUser(loggedUser)

                self?.loginView?.showLoginSuccess()
            } else {
                self?.loginView?.showLoginError(errorText: "Login failed, please try again.")
            }
        }
    }
}
