//
//  ViewController.swift
//  Cantor
//
//  Created by Igor Kalinowski on 11.07.2017.
//  Copyright © 2017 Igor Kalinowski. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

    
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        setupGoogleButton()
    }
    
    
    
    
    
    
    
    
    
    fileprivate func setupGoogleButton() {
        //Add Google In Button
        
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 60, y: 500, width: view.frame.width - 115, height: 50)
        view.addSubview(googleButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    func checkTextFields() -> Bool {
        if email.text != "" && password.text != "" {
            return true
        } else {
            return false
        }
    }
    
    func clearTextFields() {
        email.text = ""
        password.text = ""
    }

    
    @IBAction func loginTap(_ sender: Any) {
        
        //performSegue(withIdentifier: "Login", sender: self)
        
        if let emailText = email.text, let passwordText = password.text {
            FIRAuth.auth()?.signIn(withEmail: emailText, password:
                passwordText, completion: { (user, error) in
                    if let firebaseError = error {
                        print(firebaseError.localizedDescription)
                        
                        let alert = UIAlertController(title: "Warning", message: "\(firebaseError.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) -> Void in
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
                        
                        
                        
                    } else {
                        self.performSegue(withIdentifier: "Login", sender: self)
                        
                    }
                    
                    
            })
         
            
          
    }
        
        
    }
   
    @IBAction func createAccountTap(_ sender: Any){
        
        
        performSegue(withIdentifier: "Register", sender: self)
        
        
    }
    
    @IBAction func unwindToLogIn(storyboard: UIStoryboardSegue) {
    }


}

