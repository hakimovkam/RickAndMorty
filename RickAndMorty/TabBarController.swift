//
//  TabBarViewController.swift
//  RickAndMorty
//
//  Created by Камиль Хакимов on 13.01.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        viewControllers = [
        generateVC(viewController:UINavigationController(rootViewController: FirstScreenViewController()), title: "Characters", image: UIImage(systemName: "person")),
        generateVC(viewController: SecondScreenViewController(), title: "Setings", image: UIImage(systemName: "gearshape.2"))
        ]
    }
    
    
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
}
