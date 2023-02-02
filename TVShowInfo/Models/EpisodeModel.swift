//
//  EpisodeModel.swift
//  TVShowInfo
//
//  Created by Brendon Crowe on 2/1/23.
//

import Foundation


struct Episode: Decodable {
    let id: Int
    let number: Int
    let name: String
    let season: Int
    let airdate: String
    let rating: Rating
    let image: EpisodeImage?
}

struct EpisodeImage: Decodable {
    let medium: String
    let original: String
}
