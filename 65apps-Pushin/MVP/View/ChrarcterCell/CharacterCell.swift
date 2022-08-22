import UIKit
import Kingfisher

class CharacterCell: UITableViewCell {
  // MARK: - IBOutlets
  @IBOutlet var characterImage: UIImageView!
  @IBOutlet var characterNameLabel: UILabel!

  // MARK: - Methods
  func setCell(model: ModelCharacterCell, url: URL) {
    self.characterNameLabel.text = model.name
    self.characterImage.kf.setImage(with: url)
  }

  func setCellFavouriteCharacter(model: FavouriteCharacterModel) {
    self.characterNameLabel.text = model.name
    let urlSt = URL(string: model.mediumImageSize ?? "")
    self.characterImage.kf.setImage(with: urlSt)
  }
}

// MARK: - CharacterCellNib
enum CharacterCellNib {
  static let cellNib = UINib(nibName: MarvelIdentifierConstants.cellIdentifier, bundle: nil)
}
