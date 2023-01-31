//
//  ShowModel.swift
//  TVShowInfo
//
//  Created by Brendon Crowe on 1/30/23.
//

import Foundation


struct ShowDetails: Decodable {
    struct Show: Decodable {
        let url: String?
        let name: String?
        let language: String?
        let genres: [String]?
        let image: Image
        let summary: String?
    }
    let show: Show
}

struct Image: Decodable {
    let medium: String
    let original: String
}
