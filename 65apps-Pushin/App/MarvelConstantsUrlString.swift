import Foundation

// MARK: - ConstantsUrlString
enum MarvelConstantsUrlString {
  static let marvelGatewayUrlString = "https://gateway.marvel.com/"
  static let marvelCharacterlUrlString = "v1/public/characters?"
  static let marvelTimeStampString = "1"
  static let marvelApiKeyString = "9a807d81d313dd8153f93a8099dd8910"
  static let marvelHashString = "ef48b5abf5b21a18d9f9ee739a40eaa6"
  static let urlMarvel = marvelGatewayUrlString + marvelCharacterlUrlString +
    "ts=" + marvelTimeStampString +
    "&apikey=" + marvelApiKeyString +
    "&hash=" + marvelHashString
}
