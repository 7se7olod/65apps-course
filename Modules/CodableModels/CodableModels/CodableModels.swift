import Foundation

// MARK: - MarvelCharactersResponse
public struct MarvelCharactersResponse: Codable {
  public let data: MarvelCharactersData?
}

// MARK: - MarvelCharactersData
public struct MarvelCharactersData: Codable {
  public let results: [ModelCharacterResult]
}

// MARK: - MarvelCharactersResults
public struct ModelCharacterResult: Codable {
  public let id: Int?
  public let name: String?
  public let description: String?
  public let thumbnail: Thumbnail?
}

// MARK: - Thumbnail
public struct Thumbnail: Codable {
  public let path: String
  public let thumbnailExtension: Extension

  public enum CodingKeys: String, CodingKey {
    case path
    case thumbnailExtension = "extension"
  }
}

public enum Extension: String, Codable {
  case gif
  case jpg
}
