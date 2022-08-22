import Foundation
import CodableModels
import Networking
import FirebaseAuth
import FirebaseDatabase

final class CharacterPresenter: CharacterPresenterProtocol {
  // MARK: - Properties
  weak var delegate: CharacterViewable?

  private lazy var urlString = MarvelConstantsUrlString.urlMarvel
  private lazy var networking = Networking.MarvelCharacterNetworkService.self
  private var charactersResponseModel: CodableModels.MarvelCharactersResponse?

  var ref: DatabaseReference?
  var userMarvel: UserMarvel?
  var snapshotData: DataSnapshot?

  var modelCharactersResults: [CodableModels.ModelCharacterResult] = []
  var modelCharactersCells: [ModelCharacterCell] = []
  var imagesForCharacters: [ModelImageCharacter] = []

  // MARK: - Initializer
  init(delegate: CharacterViewable) {
    self.delegate = delegate

    guard let currentUser = Auth.auth().currentUser else { return }

    self.userMarvel = UserMarvel(user: currentUser)

    guard let userUid = userMarvel?.uid else { return }

    ref = Database.database().reference(withPath: "users").child(userUid).child("favouriteCharacters")

    self.ref?.observe(.value) { [weak self] snapshot in
      self?.snapshotData = snapshot
    }

    self.loadCharacters()
  }

  // MARK: - Methods
  func loadCharacters() {
    networking.fetchData(urlString: self.urlString) { [weak self] result in
      switch result {
      case .success(let hero):
        guard let result = hero.data?.results else { return }
        self?.modelCharactersResults = result
        self?.updateModelCharacterCell()
        self?.delegate?.showCharacters()
      case .failure(let error):
        print("Failure:", error)
      }
    }
  }

  func signOutUser() {
    let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
  }

  private func updateModelCharacterCell() {
    for str in modelCharactersResults {
      let standartMediumImageSize = StandartSizeImage.standardMedium.rawValue
      let standardFantasticImageSize = StandartSizeImage.standardFantastic.rawValue
      guard
        let path = str.thumbnail?.path,
        let extensionImage = str.thumbnail?.thumbnailExtension.rawValue
      else {
        return
      }

      let standartMediumImageSizeURL = path + "/" + standartMediumImageSize + "." + extensionImage
      let standartFantasticImageSizeURL = path + "/" + standardFantasticImageSize + "." + extensionImage

      let urlMediumImage = URL(string: standartMediumImageSizeURL)
      let urlFantasticImage = URL(string: standartFantasticImageSizeURL)

      let modelCharacterCell = ModelCharacterCell(
        id: str.id,
        name: str.name,
        description: str.description)

      let urlImagesCharacter = ModelImageCharacter(
        urlMediumImageSize: urlMediumImage,
        urlLargeImageSize: urlFantasticImage)

      self.imagesForCharacters.append(urlImagesCharacter)
      self.modelCharactersCells.append(modelCharacterCell)
    }
  }
}
