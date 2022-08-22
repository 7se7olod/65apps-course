import UIKit

final class RecoveryPasswordVC: UIViewController, RecoveryPasswordViewable {
  // MARK: - Properties
  private var presenter: RecoveryPasswordPresenterProtocol?

  // MARK: - IBOutlets
  @IBOutlet var passwordTextField: UITextField!
  @IBOutlet var confirmPasswordTextField: UITextField!
  @IBOutlet var saveNewPasswordButton: UIButton!

  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.presenter = RecoveryPasswordPresenter(recoveryPasswordView: self)
    navigationController?.setNavigationBarHidden(false, animated: true)
    self.passwordTextField.delegate = self
    self.confirmPasswordTextField.delegate = self
    navigationItem.backButtonTitle = ""
  }

  // MARK: - IBAction
  @IBAction func saveNewPassTapped(_ sender: UIButton) {
    self.presenter?.updatePasswordRecovery(password: self.passwordTextField.text ?? "")
    self.presenter?.updateConfirmPasswordRecovery(confirmPassword: self.confirmPasswordTextField.text ?? "")
    self.navigationController?.popToRootViewController(animated: true)
  }

  // MARK: - RecoveryPasswordViewable
  func setPasswordRecovery(password: String) {
    print("Password : \(password)")
  }

  func setConfirmPasswordRecovery(confirmPassword: String) {
    print("ConfirmPassword : \(confirmPassword)")
  }
}

extension RecoveryPasswordVC: UITextFieldDelegate {
  // MARK: - UITextFieldDelegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}
