//
//  CharacterPresenter.swift
//  RickAndMorty
//
//  Created by Камиль Хакимов on 16.01.2023.
//

import Foundation

protocol CharacterViewProtocol: AnyObject {
    func didUpdateCharacters()
    func didFailWithError(error: Error)
}

protocol CharacterViewPresenterProtocol: AnyObject {
    init(view: CharacterViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getCharacterList()
    var characters: CharacterData? { get set }
}

class CharacterPresenter: CharacterViewPresenterProtocol {
    
    weak var view: CharacterViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var characters: CharacterData?
    
    /* Через презентер обращаемся к networkService и вытаскиваем список Characters */
    func getCharacterList() {
        networkService.getCharactersList { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let characters):
                    self.characters = characters
                    self.view?.didUpdateCharacters()
                case .failure(let error):
                    self.view?.didFailWithError(error: error)
                }
            }
        }
    }
    
    required init(view: CharacterViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getCharacterList()
    }
    
    
}
