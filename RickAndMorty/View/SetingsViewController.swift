//
//  SecondScreenViewController.swift
//  RickAndMorty
//
//  Created by Камиль Хакимов on 13.01.2023.
//

import UIKit

final class SetingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1540856957, green: 0.1691044867, blue: 0.1987410784, alpha: 1)
        navigationItem.title = "Setings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        
    }
    
}

