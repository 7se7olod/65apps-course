import Foundation
import FirebaseDatabase

final class DetailCharacterPresenter: DetailCharacterPresenterProtocol {
  // MARK: - Properties
  weak var delegate: DetailCharacterViewable?

  var ref: DatabaseReference?
  var detailSnapshotData: DataSnapshot?
  var favouriteCharacters: [FavouriteCharacterModel] = []
  var favouriteStatusSwitch = false

  // MARK: - Iniializer
  init(
    delegate: DetailCharacterViewable,
    ref: DatabaseReference,
    snapshot: DataSnapshot
  ) {
    self.delegate = delegate
    self.ref = ref
    self.detailSnapshotData = snapshot
    self.loadingSnapshot()
  }

  // MARK: - Methods
  func loadingSnapshot() {
    var characters: [FavouriteCharacterModel] = []
    guard let snapshot = self.detailSnapshotData?.children else { return }
    for item in snapshot {
      let favouriteChar = FavouriteCharacterModel(snapshot: item as? DataSnapshot ?? DataSnapshot())
      characters.append(favouriteChar)
    }
    self.favouriteCharacters = characters
  }

  func addCharacterToFavourite(characrerDetail: ModelCharacterCell?, urlImageLargeSize: URL?, urlImageMediumSize: URL?) {
    self.favouriteStatusSwitch = true
    guard
      let userId = characrerDetail?.id?.description,
      let name = characrerDetail?.name else {
      return
    }
    let favouriteCharacterRef = ref?.child(userId)
    let favouriteCharacter = FavouriteCharacterModel(
      name: name,
      userId: userId,
      description: characrerDetail?.description ?? "",
      image: urlImageLargeSize?.description ?? "",
      largeImage: urlImageMediumSize?.description ?? ""
    )
    DispatchQueue.main.async {
      favouriteCharacterRef?.setValue([
        "name": favouriteCharacter.name as Any,
        "userId": favouriteCharacter.userId as Any,
        "description": favouriteCharacter.description as Any,
        "largeImageSize": favouriteCharacter.largeImageSize as Any,
        "mediumImageSize": favouriteCharacter.mediumImageSize as Any
      ])
      self.delegate?.setTitleRemoveForButton()
    }
  }

  func deleteCharacterFromFavourite(characrerDetail: ModelCharacterCell?, characterDetailFavourite: FavouriteCharacterModel?) {
    self.favouriteStatusSwitch = false
    if let uId = characterDetailFavourite?.userId {
      DispatchQueue.main.async {
        self.ref?.child(uId).removeValue()
        self.delegate?.setTitleAddForButton()
        self.delegate?.navigatePopViewController()
      }
    } else if let userId = characrerDetail?.id?.description {
      let favouriteCharacterRef = ref?.child(userId)
      DispatchQueue.main.async {
        favouriteCharacterRef?.removeValue()
        self.delegate?.setTitleAddForButton()
        self.delegate?.navigatePopViewController()
      }
    }
  }

  func setTitleForButton(cellCharacter: ModelCharacterCell?, characterDetailFavourite: FavouriteCharacterModel?) {
    DispatchQueue.main.async {
      self.favouriteStatusSwitch = self.favouriteCharacters.contains { favouriteChar -> Bool in
        if favouriteChar.userId == cellCharacter?.id?.description {
          self.delegate?.setTitleRemoveForButton()
          return true
        } else if favouriteChar.userId == characterDetailFavourite?.userId {
          self.delegate?.setTitleRemoveForButton()
          return true
        }
        self.delegate?.setTitleAddForButton()
        return false
      }
    }
  }
}
