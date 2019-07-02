//
//  Constants.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/1/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    static var userDeviceModel: String {
        get {
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136:
                    return "iPhone 5 or 5S or 5C"
                case 1334:
                    return "iPhone 6/6S/7/8"
                case 1920, 2208:
                    return "iPhone 6+/6S+/7+/8+"
                case 2436:
                    return "iPhone X"
                case 1792:
                    return "iPhone XR"
                case 2688:
                    return "iPhone XS Max"
                default:
                    return "unknown"
                }
            }
            return "unknown"
        }
    }
    
    static var buttonHeight: CGFloat {
        get {
            switch userDeviceModel {
            case "iPhone 5 or 5S or 5C", "iPhone 6/6S/7/8", "iPhone 6+/6S+/7+/8+":
                return UIScreen.main.bounds.height * pow(0.618, 4.5)
            case "iPhone X", "iPhone XS Max", "iPhone XR":
                return UIScreen.main.bounds.height * pow(0.618, 5)
            default:
                return UIScreen.main.bounds.height * pow(0.618, 4.5)
            }
        }
    }
    
    static var bottomPadding: CGFloat {
        get {
            switch userDeviceModel {
            case "iPhone 5 or 5S or 5C", "iPhone 6/6S/7/8", "iPhone 6+/6S+/7+/8+":
                return -20
            case "iPhone X", "iPhone XR", "iPhone XS Max":
                return -40
            default:
                return -40
            }
        }
    }
}

struct Colors {
    
    static var customGreen: UIColor {
        return UIColor(red:0.33, green:0.90, blue:0.55, alpha:1.0)
    }
    
    static var customRed: UIColor {
        return UIColor(red:0.93, green:0.45, blue:0.44, alpha:1.0)
    }
    
    static var backgroundRed: UIColor {
        return UIColor(red: 1.0 , green: 0.4196078431372549, blue: 0.4196078431372549, alpha:1.0)
    }
    
    static var veryLightGray: UIColor {
        return UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
    }
}
