import Foundation
import FirebaseDatabase
import FirebaseAuth

final class FavouriteCharacterListPresenter: FavouriteCharacterListPresenterProtocol {
  // MARK: - Properties
  weak var delegate: FavouriteCharacterListViewable?

  var ref: DatabaseReference?
  var userMarvel: UserMarvel?
  var snapshotData: DataSnapshot?
  var favouriteCharacters: [FavouriteCharacterModel] = []

  init(delegate: FavouriteCharacterListViewable) {
    self.delegate = delegate

    guard let currentUser = Auth.auth().currentUser else { return }

    self.userMarvel = UserMarvel(user: currentUser)

    guard let userUid = userMarvel?.uid else { return }

    ref = Database.database().reference(withPath: "users").child(userUid).child("favouriteCharacters")

    self.ref?.observe(.value) { [weak self] snapshot in
      self?.snapshotData = snapshot
      self?.loadingSnapshot()
    }
  }

  // MARK: - Methods
  func loadingSnapshot() {
    var characters: [FavouriteCharacterModel] = []
    guard let snapshot = self.snapshotData?.children else { return }
    for item in snapshot {
      let favouriteChar = FavouriteCharacterModel(snapshot: item as? DataSnapshot ?? DataSnapshot())
      characters.append(favouriteChar)
    }
    self.favouriteCharacters = characters
    self.delegate?.showFavouriteCharacters()
  }
}
