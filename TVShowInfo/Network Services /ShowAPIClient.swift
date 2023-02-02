//
//  ShowAPIClient.swift
//  TVShowInfo
//
//  Created by Brendon Crowe on 1/30/23.
//

import Foundation
import NetworkHelper


struct ShowAPIClient {
    
    static func getShows(searchQuery: String, completion: @escaping (Result<[Show], AppError>) -> ()) {
        let endpointURL =  "https://api.tvmaze.com/search/shows?q=\(searchQuery)"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { result in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let results = try JSONDecoder().decode([Show].self, from: data)
                    completion(.success(results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
