import UIKit

final class SignInVC: UIViewController, SignInViewable {
  // MARK: - Properties
  private var presenter: SignInPesenterProtocol?

  // MARK: - IBOutlets
  @IBOutlet var appLabel: UILabel!
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  @IBOutlet var signInButton: UIButton!
  @IBOutlet var forgotPasswordButton: UIButton!
  @IBOutlet var registrationButton: UIButton!

  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.presenter = SignInPresenter(signViewable: self)
    self.emailTextField.delegate = self
    self.passwordTextField.delegate = self
    self.navigationItem.backButtonTitle = ""
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.prefersLargeTitles = false
    self.navigationController?.setNavigationBarHidden(true, animated: true)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.emailTextField.text = ""
    self.passwordTextField.text = ""
  }

  // MARK: - IBActions
  @IBAction func signInButtonTapped(_ sender: UIButton) {
    self.presenter?.updatePasswordSignIn(password: self.passwordTextField.text ?? "")
    self.presenter?.updateEmailSignIn(email: self.emailTextField.text ?? "")
    self.presenter?.presentCharactersMarvelTableViewController()
  }

  @IBAction func forgotPasswordButtonTapped(_ sender: UIButton) {
    self.presenter?.updateEmailSignIn(email: self.emailTextField.text ?? "")
    self.presenter?.presentRecoveryScene()
  }

  @IBAction func registrationButtonTapped(_ sender: UIButton) {
    self.presenter?.updateEmailSignIn(email: self.emailTextField.text ?? "")
    self.presenter?.presentRegistrationScene()
  }

  // MARK: - SignInViewable
  func navigateToRegistration() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard
      let registrationViewController = storyboard.instantiateViewController(identifier: "RegistrationVC")
        as? RegistrationVC else {
      return
    }
    registrationViewController.navigationItem.title = "Create account"

    let presenterRegistration = RegistrationPresenter(registrationView: registrationViewController.self)
    presenterRegistration.updatEmailRegistration(email: self.presenter?.emailSignIn ?? "")
    self.navigationController?.pushViewController(registrationViewController, animated: true)
  }

  func navigateToRecovery() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let recoveryViewController = storyboard.instantiateViewController(identifier: "RecoveryEmailVC")
    as? RecoveryEmailVC else { return }
    recoveryViewController.navigationItem.title = "Password recovery"

    let presenterRecovery = RecoveryEmailPresenter(recoveryEmailView: recoveryViewController.self)
    presenterRecovery.updateEmailRecovery(email: self.presenter?.emailSignIn ?? "")
    self.navigationController?.pushViewController(recoveryViewController, animated: true)
  }

  func navigateToCharactersTableViewController() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let characterTableViewController = storyboard.instantiateViewController(
      identifier: "MarvelTabBarController"
    ) as? MarvelTabBarController else { return }
    characterTableViewController.navigationItem.title = "MARVEL"
    characterTableViewController.navigationItem.hidesBackButton = true
    self.navigationController?.pushViewController(characterTableViewController, animated: true)
  }

  func showAlertControllerIncorrectEmailOrPassword() {
    let alertController = UIAlertController(
      title: "Ops",
      message: "Incorrect Email or Password",
      preferredStyle: .alert
    )
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
}

extension SignInVC: UITextFieldDelegate {
  // MARK: - TextFieldDelegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}
