//
//  EpisodeAPIClient.swift
//  TVShowInfo
//
//  Created by Brendon Crowe on 2/1/23.
//

import Foundation
import NetworkHelper


struct EpisodeAPIClient {
    
    static func getEpisodes(with showID: Int, completion: @escaping (Result<[Episode], AppError>) -> ())  {
        let endpoint = "https://api.tvmaze.com/shows/\(showID)/episodes"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { result in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let episodes = try JSONDecoder().decode([Episode].self, from: data)
                    completion(.success(episodes))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
