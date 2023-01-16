//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Камиль Хакимов on 16.01.2023.
//

import Foundation

struct CharacterData: Codable {
    let info: Info
    let results: [Character]
}

struct Character: Codable {
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: OriginLocation
    let location: LastLocation
    let image: String
    let episode: [String]
}

struct OriginLocation: Codable {
    let name: String
    let url: String
}

struct LastLocation: Codable {
    let name: String
    let url: String
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
