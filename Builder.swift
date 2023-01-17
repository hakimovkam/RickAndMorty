//
//  AsselderBuilder.swift
//  RickAndMorty
//
//  Created by Камиль Хакимов on 17.01.2023.
//

import UIKit

protocol  BuilderProtocol {
    func createCharecterModule(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController
    func createLocationModule(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController
}

class ModelBuilder: BuilderProtocol {
    func createCharecterModule(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController {
        let view = CharacterViewController()
        let presenter = CharacterPresenter(view: view, networkService: networkService, router: router)
        
        view.presenter = presenter
        return view
    }
    
    func createLocationModule(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController {
        let view = LocationViewController()
        let presenter = LocationPresenter(view: view, networkService: networkService, router: router)
        
        view.presenter = presenter
        return view
    }
}
