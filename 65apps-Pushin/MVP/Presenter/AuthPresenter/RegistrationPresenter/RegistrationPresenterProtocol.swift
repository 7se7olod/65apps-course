import Foundation

protocol RegistrationPresenterProtocol {
  var registrationView: RegistrationViewable { get set }

  var emailRegistration: String { get set }

  func presentCreateAccount(name: String, email: String, password: String, confirmPassword: String)

  func updatEmailRegistration(email: String)
}
