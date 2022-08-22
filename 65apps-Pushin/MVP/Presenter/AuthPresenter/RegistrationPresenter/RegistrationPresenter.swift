import Foundation
import FirebaseAuth

class RegistrationPresenter: RegistrationPresenterProtocol {
  // MARK: - Properties
  unowned var registrationView: RegistrationViewable

  var emailRegistration: String = ""

  // MARK: - Initializer
  init(registrationView: RegistrationViewable) {
    self.registrationView = registrationView
  }

  func presentCreateAccount(name: String, email: String, password: String, confirmPassword: String) {
    self.registrationView.showData(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword
    )

    if name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
      self.registrationView.showAlertController(
        with: MarvelAlertControllerConstant.errorFormTitle,
        message: MarvelAlertControllerConstant.errorFormMessage)
      return
    }

    if password == confirmPassword {
      Auth.auth().createUser(withEmail: email, password: password) { _, error in
        guard error != nil else {
          return
        }
      }
      self.registrationView.showAlertController(
        with: MarvelAlertControllerConstant.registrationUserTitle,
        message: MarvelAlertControllerConstant.registrationUserMessage)
    } else {
      self.registrationView.showAlertController(
        with: MarvelAlertControllerConstant.passwordsConfirmTitle,
        message: MarvelAlertControllerConstant.passwordsConfirmMessage)
    }
  }

  // MARK: - Methods
  func presentEmailRegistration() {
    self.registrationView.setRegistrationEmail(email: self.emailRegistration)
  }

  func updatEmailRegistration(email: String) {
    self.emailRegistration = email
    self.presentEmailRegistration()
  }
}
