//
//  CharacterManager.swift
//  RickAndMorty
//
//  Created by Камиль Хакимов on 04.01.2023.
//

import Foundation

protocol CharacterManagerDelegate {
    func didUpdateCharacter(_ characterManager: CharacterManager, character: CharacterModel)
    func didFailWithError(error: Error)
}

struct CharacterManager {
    let urlString : String =  "https://rickandmortyapi.com/api/character"
    
    var delegate: CharacterManagerDelegate?
    
    func performRequestCharacter(with urlString: String, counter: Int) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let character = self.parseJSONCharacter(safeData, counter) {
                        self.delegate?.didUpdateCharacter(self, character: character)
                    }
                        
                }
            }
            task.resume()
        }
    }
    
    func parseJSONCharacter(_ characterData: Data, _ counter: Int) -> CharacterModel? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(CharacterData.self, from: characterData)
            
            let name = decoderData.results[counter].name
            let status = decoderData.results[counter].status
            let species = decoderData.results[counter].species
            let gender = decoderData.results[counter].gender
            let originName = decoderData.results[counter].origin.name
            let originUrl = decoderData.results[counter].origin.url
            let locationName = decoderData.results[counter].location.name
            let locationUrl = decoderData.results[counter].location.url
            let image = decoderData.results[counter].image
            let episode = decoderData.results[counter].episode
            
            return CharacterModel(name: name, status: status, species: species, gender: gender, originName: originName, originUrl: originUrl, locationName: locationName, locationUrl: locationUrl, image: image, episode: episode)
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
