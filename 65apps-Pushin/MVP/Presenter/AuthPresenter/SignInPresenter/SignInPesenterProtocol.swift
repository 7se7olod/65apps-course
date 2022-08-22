import Foundation

protocol SignInPesenterProtocol {
  var signViewable: SignInViewable { get set }

  var emailSignIn: String { get set }

  var passwordSignIn: String { get set }

  func presentRegistrationScene()

  func presentRecoveryScene()

  func updateEmailSignIn(email: String)

  func updatePasswordSignIn(password: String)

  func presentCharactersMarvelTableViewController()
}
