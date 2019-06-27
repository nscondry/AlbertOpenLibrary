//
//  Router.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/27/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation
import UIKit

enum LibraryViewControllers {
    case search
    case wishlist
}

protocol RouterDelegateProtocol: class {
    var pushViewController: ((UIViewController, LibraryViewControllers, Any?)->())? { get set }
    var popViewController: ((UIViewController, Any?)->())? { get set }
}

extension RouterDelegateProtocol {
    // makes variables optional in the protocol
    var pushViewController: ((UIViewController, LibraryViewControllers, Any?)->())? { get { return pushViewController } set {} }
    var popViewController: ((UIViewController, Any?)->())? { get { return popViewController } set {} }
}

class Router: NSObject {
    
    weak var delegate: RouterDelegateProtocol?
    
    private var window: UIWindow?
    private var tabBarController: UITabBarController!
    private var navController: UINavigationController!
    
    required init(_ window: UIWindow) {
        super.init()
        
        self.window = window
        
        // set up: tabBarController
        let searchVC = loadViewController(.search) as! SearchViewController
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "searchIcon"), selectedImage: UIImage(named: "searchIcon_selected"))
        searchVC.tabBarItem.tag = 0
        
        let wishVC = loadViewController(.wishlist) as! WishlistViewController
        wishVC.tabBarItem = UITabBarItem(title: "Wishlist", image: UIImage(named: "wishlistIcon"), selectedImage: UIImage(named: "wishlistIcon_selected"))
        wishVC.tabBarItem.tag = 1
        
        tabBarController = UITabBarController()
        tabBarController.delegate = self
        tabBarController.viewControllers = [searchVC, wishVC]
        tabBarController.selectedIndex = 0
        
        // set up: navigationController
        navController = UINavigationController(rootViewController: tabBarController)
        
        // set rootVC
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
    
    //
    // MARK: - View Controller Functions
    //
    
    private func pushViewController(_ sender: UIViewController, _ toVC: LibraryViewControllers, data: Any?) {
        // handle data when necessary
        let vc = loadViewController(toVC)
        
        navController.pushViewController(vc, animated: true)
    }
    
    private func popViewController(_ sender: UIViewController,_ data: Any?) {
        // handle data passback when necessary
        navController.popViewController(animated: true)
    }
    
    private func loadViewController(_ viewController: LibraryViewControllers) -> UIViewController {
        switch viewController {
        case .search:
            return SearchViewController()
        case .wishlist:
            return WishlistViewController()
        }
    }
}

extension Router: UITabBarControllerDelegate {
    
}
