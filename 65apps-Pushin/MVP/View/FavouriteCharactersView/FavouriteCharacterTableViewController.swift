import UIKit

class FavouriteCharacterTableViewController: UITableViewController, FavouriteCharacterListViewable {
  // MARK: - Properties
  private var presenterFavouriteChar: FavouriteCharacterListPresenterProtocol?

  private let emptyListLabel: UILabel = {
    let label = UILabel(frame: CGRect(x: 20, y: 100, width: 400, height: 200))
    label.text = "LIST OF FAVOURITE CHARACTERS IS EMPTY"
    label.font = fontOpenSansSemiBold17
    return label
  }()

  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.addSubview(self.emptyListLabel)
    self.tableView.rowHeight = 100

    self.tableView.register(
      CharacterCellNib.cellNib,
      forCellReuseIdentifier: MarvelIdentifierConstants.cellIdentifier)

    self.presenterFavouriteChar = FavouriteCharacterListPresenter(delegate: self)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.setupNavigationController()
    self.presenterFavouriteChar?.loadingSnapshot()
  }

  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.presenterFavouriteChar?.favouriteCharacters.count ?? 1
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = tableView.dequeueReusableCell(
        withIdentifier: MarvelIdentifierConstants.cellIdentifier,
        for: indexPath) as? CharacterCell,
      let character = self.presenterFavouriteChar?.favouriteCharacters[indexPath.row] else {
      return UITableViewCell()
    }

    cell.setCellFavouriteCharacter(model: character)
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    guard
      let detailCharacter = storyboard.instantiateViewController(
        identifier: MarvelIdentifierConstants.identifireDetailCharacter
      ) as? DetailCharacterViewController else { return }

    guard
      let urlString = self.presenterFavouriteChar?.favouriteCharacters[indexPath.row].largeImageSize?.description,
      let characterCell = self.presenterFavouriteChar?.favouriteCharacters[indexPath.row] else {
      return
    }

    detailCharacter.navigationItem.title = characterCell.name
    detailCharacter.imageLargeSize = URL(string: urlString)
    detailCharacter.characterDetailFavourite = characterCell
    detailCharacter.descriptionCharacter = characterCell.description
    detailCharacter.detailDatabaseRef = self.presenterFavouriteChar?.ref
    detailCharacter.detailDataSnapshot = self.presenterFavouriteChar?.snapshotData

    self.navigationController?.pushViewController(detailCharacter, animated: true)
  }

  // MARK: - Setup Navigation Controller
  private func setupNavigationController() {
    self.navigationController?.navigationBar.topItem?.hidesBackButton = true
    self.navigationController?.navigationBar.topItem?.title = "FAVOURITE"
    self.navigationController?.navigationBar.topItem?.leftBarButtonItem = nil
    self.navigationController?.navigationBar.topItem?.largeTitleDisplayMode = .automatic
  }

  // MARK: - DatabaseViewable
  func showFavouriteCharacters() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
      guard let arrayCharacterIsEmpty = self.presenterFavouriteChar?.favouriteCharacters.isEmpty else { return }
      self.emptyListLabel.isHidden = arrayCharacterIsEmpty ? false : true
    }
  }
}
