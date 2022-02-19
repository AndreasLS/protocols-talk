import Foundation

final class IntertetTools<T: Codable> {
    
    typealias CompletionHandler = (Result<T, Error>) -> Void
    
    enum InternetToolsError: Error {
        case invalidURL
        case invalidData
        case parserError(origin: Error)
    }
    
    static func get(_ urlString: String, completion: @escaping CompletionHandler) throws {
        guard let url = URL(string: urlString) else {
            completion(.failure(InternetToolsError.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(object))
                } catch {
                    completion(
                        .failure(
                            InternetToolsError.parserError(
                                origin: error)))
                }
            } else {
                completion(.failure(InternetToolsError.invalidData))
            }
        }
    }
    
}
