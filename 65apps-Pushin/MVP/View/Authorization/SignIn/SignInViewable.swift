import Foundation

protocol SignInViewable: AnyObject {
  func navigateToRegistration()

  func navigateToRecovery()

  func navigateToCharactersTableViewController()

  func showAlertControllerIncorrectEmailOrPassword()
}
