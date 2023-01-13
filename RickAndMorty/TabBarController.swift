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
        setTabBarApperance()
    }
    
    private func setUpTabBar() {
        viewControllers = [
        generateVC(viewController: UINavigationController(rootViewController: FirstScreenViewController()),
                   title: "Characters",
                   image: UIImage(systemName: "person")),
        generateVC(viewController: UINavigationController(rootViewController: SecondScreenViewController()),
                   title: "Setings",
                   image: UIImage(systemName: "gearshape.2"))
        ]
    }
    
    
    
    private func generateVC(viewController: UIViewController,
                            title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setTabBarApperance() {
        let positionOnX: CGFloat = 20
        let positionOnY: CGFloat = 10
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let rounderLayer = CAShapeLayer()
        
        let bezierPath =  UIBezierPath(roundedRect: CGRect(x:  positionOnX,
                                                           y: tabBar.bounds.minY - positionOnY ,
                                                           width: width,
                                                           height: height),
                                       cornerRadius: height / 3)
        
        rounderLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(rounderLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        rounderLayer.fillColor = UIColor.mainWhite.cgColor
        tabBar.tintColor = UIColor.tabBarItemAccent
        tabBar.unselectedItemTintColor = UIColor.tabBarItemLight
    }
}
