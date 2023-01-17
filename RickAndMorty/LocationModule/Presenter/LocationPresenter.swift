//
//  LocationPresenter.swift
//  RickAndMorty
//
//  Created by Камиль Хакимов on 17.01.2023.
//

import Foundation

protocol LocationViewProtocol: AnyObject {
    func didUpdateLocations()
    func didFailWithError(error: Error)
}

protocol LocationViewPresenterProtocol: AnyObject {
    init(view: LocationViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getLocationList()
    var locations: LocationData? { get set }
}

class LocationPresenter: LocationViewPresenterProtocol {
    
    weak var view: LocationViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var locations: LocationData?
    
    required init(view: LocationViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    func getLocationList() {
        networkService.getLocationList { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let characters):
                    self.locations = characters
                    self.view?.didUpdateLocations()
                case .failure(let error):
                    self.view?.didFailWithError(error: error)
                }
            }
        }
    }
    
    
}
