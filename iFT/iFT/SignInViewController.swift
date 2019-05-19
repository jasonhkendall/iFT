//
//  SignInViewController.swift
//  iFT
//
//  Created by Jason Howard Kendall on 5/18/19.
//  Copyright © 2019 JHK. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    // Sign-in form user/pass
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    // VC managing sign in process
    

    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }
    @IBAction func actionSignIn(_ sender: Any) {
        
        
        // Sign In
        if (txtEmail.text?.isEmpty)! || (txtPassword.text?.isEmpty)! {
            showAlert(message: "Please provide credentials")
        } else {
            Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { (result, error) in
                if let err = error {
                    self.showAlert(message: err.localizedDescription)
                } else {
                    print("user authenticated")
                    // https://coderwall.com/p/cjuzng/swift-instantiate-a-view-controller-using-its-storyboard-name-in-xcode
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "authContrllerVerficationID")
                    self.navigationController?.pushViewController(controller!, animated: true)
                }
            }
        }
    }
    
    // https://www.ioscreator.com/tutorials/display-alert-ios-tutorial
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
