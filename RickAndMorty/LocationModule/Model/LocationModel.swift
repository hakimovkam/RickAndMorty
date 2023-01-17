//
//  Model.swift
//  RickAndMorty
//
//  Created by Камиль Хакимов on 17.01.2023.
//

import Foundation

struct LocationData: Codable {
    let info: Info
    let results: [Location]
}

struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
}


