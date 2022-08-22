import Foundation

protocol RegistrationViewable: AnyObject {
  func showData(
    name: String,
    email: String,
    password: String,
    confirmPassword: String
  )

  func setRegistrationEmail(email: String)

  func showAlertController(with title: String, message: String)
}
