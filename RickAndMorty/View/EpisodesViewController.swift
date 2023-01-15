//
//  EpisodesViewController.swift
//  RickAndMorty
//
//  Created by Камиль Хакимов on 14.01.2023.
//

import UIKit

final class EpisodesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.1540856957, green: 0.1691044867, blue: 0.1987410784, alpha: 1)
        navigationItem.title = "Episodes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
    }
    
}
