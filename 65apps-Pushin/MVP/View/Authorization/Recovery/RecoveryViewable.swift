import Foundation

protocol RecoveryEmailViewable: AnyObject {
  func setEmailRecovery(email: String)

  func navigateToRecoveryPasswordScreen()
}

protocol RecoveryPasswordViewable: AnyObject {
  func setPasswordRecovery(password: String)

  func setConfirmPasswordRecovery(confirmPassword: String)
}
