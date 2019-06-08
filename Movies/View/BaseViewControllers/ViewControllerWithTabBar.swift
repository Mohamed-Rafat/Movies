//
//  ViewControllerWithTabBar.swift
//  Movies
//
//  Created by MohamedRafat on 6/7/19.
//  Copyright © 2019 ATeam. All rights reserved.
//

import UIKit

class MainTabBarController {
    static let instance = UITabBarController()
    private init(){}
}

class ViewControllerWithTabBar: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func instantiateTabBarController(animated: Bool = true){
        setupTabBarController()
        present(MainTabBarController.instance, animated: animated, completion: nil)
    }
    
    func setupTabBar(){
        MainTabBarController.instance.tabBar.barTintColor = ColorPalette.tabBarColor
        removeTabbarItemsText()
        MainTabBarController.instance.selectedIndex = 2
    }
    
    func removeTabbarItemsText() {
        if let items = MainTabBarController.instance.tabBar.items {
            for item in items {
                item.title = ""
                item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0);
            }
        }
    }
    
    
    func setupTabBarController(){
        let moviesVC = MoviesViewController.instantiate(fromAppStoryboard: .Main)
        moviesVC.tabBarItem = UITabBarItem.init(title: "Movies", image: #imageLiteral(resourceName: "nav_home_inactive").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "nav_home_active").withRenderingMode(.alwaysOriginal))
        
        let favouriteMoviesVC = FavouriteMoviesViewController.instantiate(fromAppStoryboard: .Main)
        
        favouriteMoviesVC.tabBarItem = UITabBarItem.init(title: "Favourite", image: #imageLiteral(resourceName: "nav_favorite_inactive").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "nav_favorite_active").withRenderingMode(.alwaysOriginal))
        
        MainTabBarController.instance.viewControllers = [setNavigationControllerToTabBarVCs(viewController: moviesVC) ,  setNavigationControllerToTabBarVCs(viewController: favouriteMoviesVC)]
        setupTabBar()
    }
    
    func setNavigationControllerToTabBarVCs(viewController: UIViewController)-> MainNavigationController{
        let navBar = MainNavigationController()
        navBar.viewControllers = [viewController]
        return navBar
    }

}
