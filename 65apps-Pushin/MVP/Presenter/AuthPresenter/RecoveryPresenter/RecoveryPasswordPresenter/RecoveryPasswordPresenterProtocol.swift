import Foundation

protocol RecoveryPasswordPresenterProtocol {
  var recoveryPasswordView: RecoveryPasswordViewable { get set }

  var passwordRecovery: String { get set }

  var confirmPasswordRecovery: String { get set }

  func updatePasswordRecovery(password: String)

  func updateConfirmPasswordRecovery(confirmPassword: String)
}
