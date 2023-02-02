//
//  ShowModel.swift
//  TVShowInfo
//
//  Created by Brendon Crowe on 1/30/23.
//

import Foundation


struct Show: Decodable {
    struct ShowInfo: Decodable {
        let id: Int
        let url: String?
        let name: String?
        let language: String?
        let genres: [String]?
        let image: Image
        let summary: String?
        let rating: Rating
    }
    let show: ShowInfo
}

struct Image: Decodable {
    let medium: String
    let original: String
}

struct Rating: Decodable {
    let average: Double?
}

