import Foundation
import CodableModels
import FirebaseDatabase

protocol CharacterPresenterProtocol {
  var delegate: CharacterViewable? { get set }

  var modelCharactersCells: [ModelCharacterCell] { get set }

  var modelCharactersResults: [CodableModels.ModelCharacterResult] { get set }

  var imagesForCharacters: [ModelImageCharacter] { get set }

  func signOutUser()

  var ref: DatabaseReference? { get set }

  var userMarvel: UserMarvel? { get set }

  var snapshotData: DataSnapshot? { get set }
}
