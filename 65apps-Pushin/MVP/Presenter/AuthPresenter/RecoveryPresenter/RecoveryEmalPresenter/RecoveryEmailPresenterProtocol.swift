import Foundation

protocol RecoveryEmailPresenterProtocol {
  var recoveryEmailView: RecoveryEmailViewable { get set }

  var emailRecovery: String { get set }

  func presentEmailRecovery()

  func presentRecoveryPasswordScreen()

  func updateEmailRecovery(email: String)
}
