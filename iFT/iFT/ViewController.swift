//
//  ViewController.swift
//  iFT
//
//  Created by Jason Howard Kendall on 5/14/19.
//  Copyright © 2019 JHK. All rights reserved.
//

//import UIKit
//import FirebaseAuth
//import GoogleMaps
//import GooglePlaces

import UIKit
import GoogleMaps
import GooglePlaces
import FirebaseUI



// Stage one - Complete sign-in and sign-out / User authentication process


class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppearanceManager.setupAppeearance()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        // Get default auth ui
        let authUI = FUIAuth.defaultAuthUI()
        // Check that it isn't nil
        guard authUI != nil else {
            // Log the rror
            return
        }
        // Set self as the delegate
        authUI?.delegate = self
        authUI?.providers = [FUIEmailAuth()]
        // Get a reference to the auth UI view controller
        let authViewController = authUI!.authViewController()
        // Show it
        present(authViewController, animated: true, completion: nil)
    }
    
    
}

extension ViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult:
        AuthDataResult?, error: Error?) {
        guard error == nil else {
            return
        }
        performSegue(withIdentifier: "goHome", sender: self)
    }
}

