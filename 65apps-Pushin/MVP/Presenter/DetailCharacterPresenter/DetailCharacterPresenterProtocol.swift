import Foundation
import FirebaseDatabase

protocol DetailCharacterPresenterProtocol {
  var delegate: DetailCharacterViewable? { get set }

  var ref: DatabaseReference? { get set }

  var favouriteCharacters: [FavouriteCharacterModel] { get set }

  var detailSnapshotData: DataSnapshot? { get set }

  var favouriteStatusSwitch: Bool { get set }

  func loadingSnapshot()

  func addCharacterToFavourite(characrerDetail: ModelCharacterCell?, urlImageLargeSize: URL?, urlImageMediumSize: URL?)

  func deleteCharacterFromFavourite(characrerDetail: ModelCharacterCell?, characterDetailFavourite: FavouriteCharacterModel?)

  func setTitleForButton(cellCharacter: ModelCharacterCell?, characterDetailFavourite: FavouriteCharacterModel?)
}
