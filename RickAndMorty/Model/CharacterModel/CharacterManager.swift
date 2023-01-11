//
//  CharacterManager.swift
//  RickAndMorty
//
//  Created by Камиль Хакимов on 04.01.2023.
//

import Foundation

protocol CharacterManagerDelegate {
    func didUpdateCharacter(_ characterManager: CharacterManager, character: [CharacterModel])
    func didFailWithError(error: Error)
}

struct CharacterManager {
    let urlString : String =  "https://rickandmortyapi.com/api/character"
    var nextPagesUrlString: String?
    var previousPagesUrlString: String?
    
    var delegate: CharacterManagerDelegate?
    
    func performRequestCharacter(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let character = self.parseJSONCharacter(safeData) {
                        self.delegate?.didUpdateCharacter(self, character: character)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSONCharacter(_ characterData: Data) -> [CharacterModel]? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(CharacterData.self, from: characterData)
            var result: [CharacterModel] = []
            for i in 0...19 {
                let name = decoderData.results[i].name
                let status = decoderData.results[i].status
                let species = decoderData.results[i].species
                let gender = decoderData.results[i].gender
                let originName = decoderData.results[i].origin.name
                let originUrl = decoderData.results[i].origin.url
                let locationName = decoderData.results[i].location.name
                let locationUrl = decoderData.results[i].location.url
                let image = decoderData.results[i].image
                let episode = decoderData.results[i].episode
                
                result.append(CharacterModel(name: name, status: status, species: species, gender: gender, originName: originName, originUrl: originUrl, locationName: locationName, locationUrl: locationUrl, image: image, episode: episode))
            }
            return result
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}

