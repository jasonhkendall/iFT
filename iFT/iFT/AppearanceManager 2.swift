//
//  AppearanceManager.swift
//  iFT
//
//  Created by Jason Howard Kendall on 5/22/19.
//  Copyright © 2019 JHK. All rights reserved.
//

import Foundation
import UIKit
import FirebaseUI
import GoogleMaps
import GooglePlaces


// Working with appearance proxy

class AppearanceManager {
    class func setupAppeearance() {
        // Applied global appearance for the navigation bar
      let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 30)!, NSAttributedString.Key.foregroundColor: UIColor.orange]
        
//        let navbarCompactAppearance = UINavigationBar.appearance(for: UITraitCollection.init(verticalSizeClass: .compact))
//        navbarCompactAppearance.titleTextAttributes =
//            [NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 20)!,
//             NSAttributedString.Key.foregroundColor: UIColor.orange]
    }
}
