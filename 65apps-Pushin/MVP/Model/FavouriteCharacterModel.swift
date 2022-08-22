import Foundation
import Firebase

struct FavouriteCharacterModel {
  let name: String?
  let userId: String?
  let description: String?
  let largeImageSize: String?
  let mediumImageSize: String?
  let ref: DatabaseReference?

  init(name: String, userId: String, description: String, image: String, largeImage: String) {
    self.name = name
    self.userId = userId
    self.description = description
    self.ref = nil
    self.largeImageSize = image
    self.mediumImageSize = largeImage
  }

  init(snapshot: DataSnapshot) {
    let snapshotValue = snapshot.value as? [String: AnyObject]
    name = snapshotValue?["name"] as? String ?? ""
    userId = snapshotValue?["userId"] as? String ?? ""
    largeImageSize = snapshotValue?["largeImageSize"] as? String ?? ""
    mediumImageSize = snapshotValue?["mediumImageSize"] as? String ?? ""
    description = snapshotValue?["description"] as? String ?? ""
    ref = snapshot.ref
  }
}
