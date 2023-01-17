//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Камиль Хакимов on 16.01.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getCharactersList(completion: @escaping (Result<CharacterData?, Error>) -> Void)
    func getLocationList(completion: @escaping (Result<LocationData?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getCharactersList(completion: @escaping (Result<CharacterData?, Error>) -> Void) {
        let urlString = "https://rickandmortyapi.com/api/character"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
                
            do {
                let obj = try JSONDecoder().decode(CharacterData.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        } .resume()
    }
    
    func getLocationList(completion: @escaping (Result<LocationData?, Error>) -> Void) {
        let urlString = "https://rickandmortyapi.com/api/location"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
                
            do {
                let obj = try JSONDecoder().decode(LocationData .self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        } .resume()
    }
}

