import Foundation
import CodableModels

public final class MarvelCharacterNetworkService {
  // MARK: - Initializer
  public init() {}

  // MARK: - Получение данных из сети
  public static func fetchData(
    urlString: String,
    completion: @escaping (Result<MarvelCharactersResponse, Error>) -> Void
  ) {
    guard let url = URL(string: urlString) else { return }

    let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print(error.localizedDescription)
        completion(.failure(error))
        return
      }

      guard let response = response as? HTTPURLResponse else { return }
      print(response.statusCode)

      guard let data = data else { return }
      do {
        let result = try JSONDecoder().decode(MarvelCharactersResponse.self, from: data)
        completion(.success(result))
      } catch let jsonError {
        completion(.failure(jsonError))
      }
    }
    dataTask.resume()
  }
}
