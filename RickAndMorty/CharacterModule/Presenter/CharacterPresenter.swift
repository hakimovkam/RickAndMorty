//
//  File.swift
//  RickAndMorty
//
//  Created by Камиль Хакимов on 15.01.2023.
//

import Foundation

protocol CharacterViewPresenterProtocol: AnyObject {
    init(view: CharacterViewProtocol, model: CharacterModel)
}

protocol CharacterViewProtocol: AnyObject {
    func didUpdateCharacter(_ characterManager: CharacterManager, character: [CharacterModel])
    func didFailWithError(error: Error)
}


class CharacterPresenter: CharacterViewPresenterProtocol {
    let view: CharacterViewProtocol
    let model: CharacterModel
    
    let urlString : String =  "https://rickandmortyapi.com/api/character"
    var nextPagesUrlString: String?
    var previousPagesUrlString: String?
    
    func performRequestCharacter(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    
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
                let originLocationName = decoderData.results[i].origin.name
                let originLocationUrl = decoderData.results[i].origin.url
                let lastLocationName = decoderData.results[i].location.name
                let lastLocationUrl = decoderData.results[i].location.url
                let image = decoderData.results[i].image
                let episode = decoderData.results[i].episode
                
                result.append(CharacterModel(name: name, status: status,
                                             species: species, gender: gender,
                                             originLocationName: originLocationName,
                                             originLocationUrl: originLocationUrl,
                                             lastLocationName: lastLocationName,
                                             lastLocationUrl: lastLocationUrl,
                                             image: image, episode: episode))
            }
            return result
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    required init(view: CharacterViewProtocol, model: CharacterModel) {
        self.view = view
        self.model = model
    }
}
