//
//  SignOutViewController.swift
//  iFT
//
//  Created by Jason Howard Kendall on 5/18/19.
//  Copyright © 2019 JHK. All rights reserved.
//

import UIKit
import FirebaseUI
import GoogleMaps
import GooglePlaces


class SignOutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppearanceManager.setupAppeearance()
        // Do any additional setup after loading the view.
    }
    
    
    
    //@IBAction func goToMapsVC(_ sender: UIButton) {
    
    // let controller = self.storyboard?.instantiateViewController(withIdentifier: "MapsViewController")
    //    self.navigationController?.pushViewController(controller!, animated: true)
        
      //  let controller = self.storyboard!.instantiateViewController(withIdentifier: "MapsViewController") as! ViewController
     //   self.navigationController!.pushViewController(controller, animated: true)
   // }
        
    
    @IBAction func actionSignOut(_ sender: Any) {
        // Firebase logout API
        try! Auth.auth().signOut()
        
        // **Need code to pop view controllers off the current stack, so that logout returns to initial VC - find code for this problem**
        
        let ViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "MainID") as UIViewController
        UIApplication.shared.keyWindow?.rootViewController = ViewController
    }
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


