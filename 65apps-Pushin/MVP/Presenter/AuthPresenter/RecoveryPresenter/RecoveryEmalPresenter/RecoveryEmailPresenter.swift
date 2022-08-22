import Foundation

class RecoveryEmailPresenter: RecoveryEmailPresenterProtocol {
  // MARK: - Properties
  unowned var recoveryEmailView: RecoveryEmailViewable

  var emailRecovery: String = ""

  // MARK: - Initializer
  init(recoveryEmailView: RecoveryEmailViewable) {
    self.recoveryEmailView = recoveryEmailView
  }

  // MARK: - Methods
  func presentEmailRecovery() {
    self.recoveryEmailView.setEmailRecovery(email: emailRecovery)
  }

  func presentRecoveryPasswordScreen() {
    self.recoveryEmailView.navigateToRecoveryPasswordScreen()
  }

  func updateEmailRecovery(email: String) {
    self.emailRecovery = email
    self.presentEmailRecovery()
  }
}
