//
//  LocationViewController.swift
//  RickAndMorty
//
//  Created by Камиль Хакимов on 17.01.2023.
//

import UIKit

class LocationViewController: UIViewController {
    
    var presenter: LocationViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Location"
    }
}

extension LocationViewController: LocationViewProtocol {
    func didUpdateLocations() {
        print("update")
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
    
    
}
