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

class CharacterManager {
    let urlString : String =  "https://rickandmortyapi.com/api/character"
    
    var delegate: CharacterManagerDelegate?
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {

                    if let character = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCharacter(self, character: character)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ characterData: Data) -> CharacterModel? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(CharacterData.self, from: characterData)
            
            return nil // заглушка
        } catch {
            print(error)
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
