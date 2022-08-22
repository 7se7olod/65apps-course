import UIKit

class CharactersMarvelTableViewController: UITableViewController, CharacterViewable {
  // MARK: - Properties
  private var presenterCharacter: CharacterPresenterProtocol?

  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupNavigationController()
    self.tableView.rowHeight = 100

    self.tableView.register(
      CharacterCellNib.cellNib,
      forCellReuseIdentifier: MarvelIdentifierConstants.cellIdentifier)

    self.presenterCharacter = CharacterPresenter(delegate: self)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.setupNavigationController()
  }

  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.presenterCharacter?.modelCharactersResults.count ?? 1
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = tableView.dequeueReusableCell(
        withIdentifier: MarvelIdentifierConstants.cellIdentifier,
        for: indexPath) as? CharacterCell,
      let nameCharacter = self.presenterCharacter?.modelCharactersCells[indexPath.row],
      let imageMediumSize = self.presenterCharacter?.imagesForCharacters[indexPath.row].urlMediumImageSize else {
      return UITableViewCell()
    }

    cell.setCell(model: nameCharacter, url: imageMediumSize)
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.tableView.deselectRow(at: indexPath, animated: true)
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    guard
      let detailCharacter = storyboard.instantiateViewController(
        identifier: MarvelIdentifierConstants.identifireDetailCharacter)
        as? DetailCharacterViewController else {
      return
    }

    guard
      let urlImageMediumSize = presenterCharacter?.imagesForCharacters[indexPath.row].urlMediumImageSize,
      let urlImageLargeSize = presenterCharacter?.imagesForCharacters[indexPath.row].urlLargeImageSize,
      let cellCharacter = presenterCharacter?.modelCharactersCells[indexPath.row] else {
      return
    }

    detailCharacter.navigationItem.title = cellCharacter.name
    detailCharacter.characrerDetail = cellCharacter
    detailCharacter.imageLargeSize = urlImageLargeSize
    detailCharacter.imageMediumSize = urlImageMediumSize
    detailCharacter.descriptionCharacter = cellCharacter.description
    detailCharacter.detailDatabaseRef = self.presenterCharacter?.ref
    detailCharacter.detailDataSnapshot = self.presenterCharacter?.snapshotData

    self.navigationController?.pushViewController(detailCharacter, animated: true)
  }

  // MARK: - Setup Navigation Controller
  private func setupNavigationController() {
    let signOutLeftButtonItem = UIBarButtonItem(
      title: "SIGN OUT",
      style: .plain,
      target: self,
      action: #selector(signOutUser)
    )

    self.navigationController?.navigationBar.topItem?.leftBarButtonItem = signOutLeftButtonItem
    self.navigationController?.navigationBar.topItem?.title = "MARVEL"
    self.navigationController?.navigationBar.topItem?.hidesBackButton = true
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    self.navigationController?.navigationBar.prefersLargeTitles = true
  }

  @objc private func signOutUser() {
    let alertController = UIAlertController(
      title: "Attention",
      message: "Are you sure you want to log out of your account?",
      preferredStyle: .alert)
    let leaveAction = UIAlertAction(title: "Leave", style: .destructive) { [weak self] _ in
      self?.presenterCharacter?.signOutUser()
      self?.navigationController?.popToRootViewController(animated: true)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alertController.addAction(leaveAction)
    alertController.addAction(cancelAction)
    present(alertController, animated: true, completion: nil)
  }

  // MARK: - CharacterViewable
  func showCharacters() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
}
