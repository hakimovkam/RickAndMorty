//
//  CharacterData.swift
//  RickAndMorty
//
//  Created by Камиль Хакимов on 04.01.2023.
//

import Foundation

struct CharacterData: Codable {
    let info: Info
    let results: [Results]
}

struct Results: Codable {
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
}

struct Origin: Codable {
    let name: String
    let url: String
}

struct Location: Codable {
    let name: String
    let url: String
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String
}
