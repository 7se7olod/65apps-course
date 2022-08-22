import Foundation
import FirebaseAuth

class SignInPresenter: SignInPesenterProtocol {
  // MARK: - Properties
  unowned var signViewable: SignInViewable

  var emailSignIn: String = ""

  var passwordSignIn: String = ""

  // MARK: - Initializer
  init(signViewable: SignInViewable) {
    self.signViewable = signViewable
  }

  // MARK: - Methods
  func presentCharactersMarvelTableViewController() {
    Auth.auth().signIn(withEmail: emailSignIn, password: passwordSignIn) { [weak self] auth, error in
      guard error == nil else {
      print("Ошибка!")
        self?.signViewable.showAlertControllerIncorrectEmailOrPassword()
        return
      }
      guard auth != nil else { return }
      print("Успех!")
      self?.signViewable.navigateToCharactersTableViewController()
    }
  }

  func updateEmailSignIn(email: String) {
    self.emailSignIn = email
  }

  func updatePasswordSignIn(password: String) {
    self.passwordSignIn = password
  }

  func presentRegistrationScene() {
    self.signViewable.navigateToRegistration()
  }

  func presentRecoveryScene() {
    self.signViewable.navigateToRecovery()
  }
}
