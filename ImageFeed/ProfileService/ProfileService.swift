
import Foundation

final class ProfileService {
    private let urlSession = URLSession.shared
    static let shared = ProfileService()
    var profileResult: UserProfileResult?
    
    func fetchProfile(_ token: String, completion: @escaping (Result<UserProfileResult, Error>) -> Void) {
        guard let url = URL(string: defaultBaseURL + "me") else { return }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = object(for: request) { [weak self] (result: Result<UserProfileResult, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let profile):
                self.profileResult = profile
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

extension ProfileService {
    private func object(
        for request: URLRequest,
        completion: @escaping (Result<UserProfileResult, Error>) -> Void
    ) -> URLSessionTask {
        let decoder = JSONDecoder()
        return urlSession.data(for: request) { (result: Result<Data, Error>) in
            let response = result.flatMap { data -> Result<UserProfileResult, Error> in
                Result { try decoder.decode(UserProfileResult.self, from: data) }
            }
            completion(response)
        }
    }
}
