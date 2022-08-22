import UIKit

final class RegistrationVC: UIViewController, RegistrationViewable {
  // MARK: - Properties
  private var presenter: RegistrationPresenterProtocol?
  private var emailRegistration: String?

  // MARK: - IBOutlets
  @IBOutlet var nameTextField: UITextField!
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  @IBOutlet var confirmPasswordTextField: UITextField!
  @IBOutlet var createAccountButton: UIButton!
  @IBOutlet var alreadyHaveAnAccountButton: UIButton!

  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.presenter = RegistrationPresenter(registrationView: self)
    navigationController?.setNavigationBarHidden(false, animated: true)
    self.nameTextField.delegate = self
    self.emailTextField.delegate = self
    self.passwordTextField.delegate = self
    self.confirmPasswordTextField.delegate = self
    navigationItem.backButtonTitle = ""
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.emailTextField.text = self.emailRegistration
  }

  // MARK: - IBAction
  @IBAction func alreadyHaveAnAccountButtonTapped(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }

  @IBAction func createAccountTapButton(_ sender: UIButton) {
    self.presenter?.presentCreateAccount(
      name: self.nameTextField.text ?? "",
      email: self.emailTextField.text ?? "",
      password: self.passwordTextField.text ?? "",
      confirmPassword: self.confirmPasswordTextField.text ?? ""
    )
  }

  // MARK: - RegistrationViewable
  func showData(name: String, email: String, password: String, confirmPassword: String) {
    print("Name : \(name)")
    print("Email: \(email)")
    print("Password : \(password)")
    print("Confirm password: \(confirmPassword)")
  }

  func setRegistrationEmail(email: String) {
    self.emailRegistration = email
    self.navigationController?.popViewController(animated: true)
  }

  func showAlertController(with title: String, message: String) {
    let alertController = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert)

    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    let okRegistration = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
      self?.navigationController?.popToRootViewController(animated: true)
    }

    if title == MarvelAlertControllerConstant.registrationUserTitle {
      alertController.addAction(okRegistration)
      self.present(alertController, animated: true, completion: nil)
    } else {
      alertController.addAction(okAction)
      self.present(alertController, animated: true, completion: nil)
    }
  }
}

  extension RegistrationVC: UITextFieldDelegate {
  // MARK: - TextFieldDelegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}
