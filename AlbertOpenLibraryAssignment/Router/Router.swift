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
    case detail
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
    private var searchNav: UINavigationController!
    private var wishNav: UINavigationController!
    
    required init(_ window: UIWindow) {
        super.init()
        
        self.window = window
        
        // set up: navControllers
        let searchVC = loadViewController(.search) as! SearchViewController
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "searchIcon"), selectedImage: UIImage(named: "searchIcon_selected"))
        searchVC.tabBarItem.tag = 0
        searchNav = UINavigationController(rootViewController: searchVC)
        
        let wishVC = loadViewController(.wishlist) as! WishlistViewController
        wishVC.tabBarItem = UITabBarItem(title: "Wishlist", image: UIImage(named: "wishlistIcon"), selectedImage: UIImage(named: "wishlistIcon_selected"))
        wishVC.tabBarItem.tag = 1
        wishNav = UINavigationController(rootViewController: wishVC)
        
        // set up: tabController
        tabBarController = UITabBarController()
        tabBarController.delegate = self
        tabBarController.viewControllers = [searchNav, wishNav]
        tabBarController.selectedIndex = 0
        
        // set rootVC
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }
    
    //
    // MARK: - View Controller Functions
    //
    
    private func pushViewController(_ sender: UIViewController, _ toVC: LibraryViewControllers, data: Any?) {
        // handle data when necessary
        let vc = loadViewController(toVC)
        
        if let nav = sender.navigationController {
            nav.pushViewController(vc, animated: true)
        } else {
            NSLog("[Router] Error: failed to push view controller")
        }
    }
    
    private func popViewController(_ sender: UIViewController,_ data: Any?) {
        // handle data passback when necessary
        if let nav = sender.navigationController {
            nav.popViewController(animated: true)
        } else {
            NSLog("[Router] Error: failed to pop view controller")
        }
    }
    
    private func loadViewController(_ viewController: LibraryViewControllers) -> UIViewController {
        let vc: UIViewController!
        switch viewController {
        case .search:
            vc = SearchViewController()
        case .wishlist:
            vc = WishlistViewController()
        case .detail:
            vc = BookDetailViewController()
        }
        if let vc = vc as? RouterDelegateProtocol {
            vc.pushViewController = self.pushViewController
            vc.popViewController = self.popViewController
        }
        return vc
    }
}

extension Router: UITabBarControllerDelegate {
    // to do
}
