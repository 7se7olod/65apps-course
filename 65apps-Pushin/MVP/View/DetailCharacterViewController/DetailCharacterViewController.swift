import UIKit
import Kingfisher
import FirebaseDatabase

class DetailCharacterViewController: UIViewController, DetailCharacterViewable {
  // MARK: - Properties
  private var presenterDetail: DetailCharacterPresenterProtocol?
  var detailDatabaseRef: DatabaseReference?
  var detailDataSnapshot: DataSnapshot?

  private let characterIsEmptyText = "THIS IS CHARACTER HAVE NOT DESCRIPTION"
  private let removeFromFavouritesText = "REMOVE FROM FAVOURITES"
  private let addToFavouritesText = "ADD TO FAVOURITES"

  var imageLargeSize: URL?
  var imageMediumSize: URL?
  var descriptionCharacter: String?
  var characterDetailFavourite: FavouriteCharacterModel?
  var characrerDetail: ModelCharacterCell?

  // MARK: - IBOutlets
  @IBOutlet var detailCharacterImageView: UIImageView!
  @IBOutlet var addToFavouriteButton: UIButton!
  @IBOutlet var characterDescriptionLabel: UILabel!

  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()

    self.presenterDetail = DetailCharacterPresenter(
      delegate: self,
      ref: self.detailDatabaseRef ?? DatabaseReference(),
      snapshot: self.detailDataSnapshot ?? DataSnapshot()
    )

    self.characterDescriptionLabel.layer.masksToBounds = true
    self.characterDescriptionLabel.layer.cornerRadius = 15

    self.detailCharacterImageView.kf.setImage(with: self.imageLargeSize)

    guard let isEmptyCharacterDescription = self.descriptionCharacter?.isEmpty else { return }
    self.characterDescriptionLabel.text = isEmptyCharacterDescription ?
      characterIsEmptyText : self.descriptionCharacter
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.presenterDetail?.loadingSnapshot()
    self.presenterDetail?.setTitleForButton(
      cellCharacter: self.characrerDetail,
      characterDetailFavourite: self.characterDetailFavourite)
  }

  // MARK: - IBActions
  @IBAction func addToFavouriteTapped(_ sender: UIButton) {
    if self.presenterDetail?.favouriteStatusSwitch == false {
      self.presenterDetail?.addCharacterToFavourite(
        characrerDetail: self.characrerDetail,
        urlImageLargeSize: self.imageLargeSize,
        urlImageMediumSize: self.imageMediumSize)
    } else if self.presenterDetail?.favouriteStatusSwitch == true {
      self.presenterDetail?.deleteCharacterFromFavourite(
        characrerDetail: self.characrerDetail,
        characterDetailFavourite: self.characterDetailFavourite)
    }
  }

  @IBAction func imageViewTapped(_ sender: UITapGestureRecognizer) {
    guard let imageView = sender.view as? UIImageView else { return }
    let newImageView = UIImageView(image: imageView.image)

    newImageView.frame = UIScreen.main.bounds
    newImageView.backgroundColor = .black
    newImageView.contentMode = .scaleAspectFit
    newImageView.isUserInteractionEnabled = true

    let tapImageGesture = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
    let pinchImageGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchImageView))

    newImageView.addGestureRecognizer(tapImageGesture)
    newImageView.addGestureRecognizer(pinchImageGesture)

    self.view.addSubview(newImageView)
    self.navigationController?.isNavigationBarHidden = true
    self.tabBarController?.tabBar.isHidden = true
  }

  // MARK: - Gesture Methods
  @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
    self.navigationController?.isNavigationBarHidden = false
    self.tabBarController?.tabBar.isHidden = false
    sender.view?.removeFromSuperview()
  }

  @objc func pinchImageView(_ sender: UIPinchGestureRecognizer) {
    let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)

    guard
      let scale = scaleResult,
      scale.a > 1,
      scale.d > 1 else { return }
    sender.view?.transform = scale
    sender.scale = 1
  }

  // MARK: - DatabseViewable
  func navigatePopViewController() {
    self.navigationController?.popViewController(animated: true)
  }

  func setTitleRemoveForButton() {
    self.addToFavouriteButton.setTitle(removeFromFavouritesText, for: .normal)
  }

  func setTitleAddForButton() {
    self.addToFavouriteButton.setTitle(addToFavouritesText, for: .normal)
  }
}
