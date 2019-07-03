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
    case browse
}

protocol RouterDelegateProtocol: class {
    var presentViewController: ((UIViewController, LibraryViewControllers, Any?)->())? { get set }
}

extension RouterDelegateProtocol {
    // makes variables optional in the protocol
    var presentViewController: ((UIViewController, LibraryViewControllers, Any?)->())? { get { return presentViewController } set {} }
}

class Router: NSObject {
    
    weak var delegate: RouterDelegateProtocol?
    
    private var window: UIWindow?
    private var tabBarController: UITabBarController!
    private var browseNav: UINavigationController!
    private var wishNav: UINavigationController!
    
    required init(_ window: UIWindow) {
        super.init()
        
        self.window = window
        
        // set up: navControllers
        let browseVC = loadViewController(.browse) as! BrowseViewController
        browseVC.tabBarItem = UITabBarItem(title: "Browse", image: UIImage(named: "searchIcon"), selectedImage: UIImage(named: "searchIcon_selected"))
        browseVC.tabBarItem.tag = 0
        browseNav = UINavigationController(rootViewController: browseVC)
        
        let wishVC = loadViewController(.wishlist) as! WishlistViewController
        wishVC.tabBarItem = UITabBarItem(title: "Wishlist", image: UIImage(named: "wishlistIcon"), selectedImage: UIImage(named: "wishlistIcon_selected"))
        wishVC.tabBarItem.tag = 1
        wishNav = UINavigationController(rootViewController: wishVC)
        
        // set up: tabController
        tabBarController = UITabBarController()
        tabBarController.delegate = self
        tabBarController.viewControllers = [browseNav, wishNav]
        tabBarController.selectedIndex = 0
        tabBarController.tabBar.isTranslucent = false
        
        // set rootVC
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }
    
    //
    // MARK: - View Controller Functions
    //
    
    private func presentViewController(_ sender: UIViewController, toPresent: LibraryViewControllers, data: Any?) {
        // handle data when necessary
        let vc = loadViewController(toPresent)
        
        if let data = data as? BookData, let vc = vc as? BookDetailViewController {
            vc.data = data
        }
        
        if let data = data as? BrowsedBookData, let vc = vc as? BookDetailViewController {
            vc.data = BookData(fromBrowsedData: data)
        }
        
        sender.present(vc, animated: true, completion: nil)
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
        case .browse:
            vc = BrowseViewController()
        }
        if let vc = vc as? RouterDelegateProtocol {
            vc.presentViewController = self.presentViewController
        }
        return vc
    }
}

extension Router: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        var index: Int
        switch viewController {
        // index 0 = tabBarBackground
        case browseNav:
            index = 1
        case wishNav:
            index = 2
        default:
            return
        }
        if let tabItemView = tabBarController.tabBar.subviews[index] as? UIView {
            tabItemView.bounce()
        }
    }
}
