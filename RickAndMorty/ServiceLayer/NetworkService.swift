//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Камиль Хакимов on 16.01.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getCharactersList(completion: @escaping (Result<CharacterData?, Error>) -> Void)
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
                
//            if let safeData = data {
//                if let chatacter = self.parseJSONCharacter(safeData) {
//                    completion(.success(chatacter))
//                }
//            }
            do {
                let obj = try JSONDecoder().decode(CharacterData.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        } .resume()
    }
    
//    func parseJSONCharacter(_ characterData: Data) -> [CharacterModel]? {
//        let decoder = JSONDecoder()
//        do {
//            let decoderData = try decoder.decode(CharacterData.self, from: characterData)
//            var result: [CharacterModel] = []
//            for i in 0...19 {
//                let name = decoderData.results[i].name
//                let status = decoderData.results[i].status
//                let species = decoderData.results[i].species
//                let gender = decoderData.results[i].gender
//                let originLocationName = decoderData.results[i].origin.name
//                let originLocationUrl = decoderData.results[i].origin.url
//                let lastLocationName = decoderData.results[i].location.name
//                let lastLocationUrl = decoderData.results[i].location.url
//                let image = decoderData.results[i].image
//                let episode = decoderData.results[i].episode
//
//                result.append(CharacterModel(name: name, status: status,
//                                             species: species, gender: gender,
//                                             originLocationName: originLocationName,
//                                             originLocationUrl: originLocationUrl,
//                                             lastLocationName: lastLocationName,
//                                             lastLocationUrl: lastLocationUrl,
//                                             image: image, episode: episode))
//            }
//            return result
//        } catch {
//            return nil
//        }
//    }
}
