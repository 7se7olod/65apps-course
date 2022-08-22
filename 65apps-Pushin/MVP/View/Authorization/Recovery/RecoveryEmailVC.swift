import UIKit

final class RecoveryEmailVC: UIViewController, RecoveryEmailViewable {
  // MARK: - Properties
  private var presenter: RecoveryEmailPresenterProtocol?
  private var emailRecovery: String?

  // MARK: - IBOutlets
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var sendCodeButton: UIButton!

  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.presenter = RecoveryEmailPresenter(recoveryEmailView: self)
    navigationController?.setNavigationBarHidden(false, animated: true)
    self.emailTextField.delegate = self
    navigationItem.backButtonTitle = ""
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.emailTextField.text = self.emailRecovery
  }

  // MARK: - IBAction
  @IBAction func sendCodeTapped(_ sender: UIButton) {
    self.presenter?.presentRecoveryPasswordScreen()
  }

  // MARK: - RecoveryEmailViewable
  func setEmailRecovery(email: String) {
    self.emailRecovery = email
  }

  func navigateToRecoveryPasswordScreen() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let recoveryPassVC = storyboard.instantiateViewController(identifier: "RecoveryPasswordVC")
    self.navigationController?.pushViewController(recoveryPassVC, animated: true)
  }
}

extension RecoveryEmailVC: UITextFieldDelegate {
  // MARK: - UITextFieldDelegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}
