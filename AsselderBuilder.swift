//
//  AsselderBuilder.swift
//  RickAndMorty
//
//  Created by Камиль Хакимов on 17.01.2023.
//

import UIKit

protocol  BuilderProtocol {
    func createCharecterModule() -> UIViewController
}

class ModelBuilder: BuilderProtocol {
    func createCharecterModule() -> UIViewController {
        let view = CharacterViewController()
        let networkService = NetworkService()
        let presenter = CharacterPresenter(view: view, networkService: networkService)
        
        view.presenter = presenter
        
        return view
        
    }
}
