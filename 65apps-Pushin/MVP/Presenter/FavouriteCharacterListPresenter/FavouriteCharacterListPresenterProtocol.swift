import Foundation
import FirebaseDatabase

protocol FavouriteCharacterListPresenterProtocol {
  var delegate: FavouriteCharacterListViewable? { get set }

  var ref: DatabaseReference? { get set }

  var userMarvel: UserMarvel? { get set }

  var snapshotData: DataSnapshot? { get set }

  var favouriteCharacters: [FavouriteCharacterModel] { get set }

  func loadingSnapshot()
}
