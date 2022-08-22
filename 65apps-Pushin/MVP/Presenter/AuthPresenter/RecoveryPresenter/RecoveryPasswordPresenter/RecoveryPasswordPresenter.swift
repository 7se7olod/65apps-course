import Foundation

class RecoveryPasswordPresenter: RecoveryPasswordPresenterProtocol {
  // MARK: - Properties
  unowned var recoveryPasswordView: RecoveryPasswordViewable

  var passwordRecovery: String = ""

  var confirmPasswordRecovery: String = ""

  // MARK: - Initializer
  init(recoveryPasswordView: RecoveryPasswordViewable) {
    self.recoveryPasswordView = recoveryPasswordView
  }

  // MARK: - Methods
  private func presentPasswordRecovery() {
    self.recoveryPasswordView.setPasswordRecovery(password: self.passwordRecovery)
  }

  private func presentConfirmPasswordRecovery() {
    self.recoveryPasswordView.setConfirmPasswordRecovery(confirmPassword: self.confirmPasswordRecovery)
  }

  func updatePasswordRecovery(password: String) {
    self.passwordRecovery = password
    self.presentPasswordRecovery()
  }

  func updateConfirmPasswordRecovery(confirmPassword: String) {
    self.confirmPasswordRecovery = confirmPassword
    self.presentConfirmPasswordRecovery()
  }
}
