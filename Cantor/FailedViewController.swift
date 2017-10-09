//
//  FailedViewController.swift
//  Cantor
//
//  Created by Igor Kalinowski on 12.07.2017.
//  Copyright © 2017 Igor Kalinowski. All rights reserved.
//

import UIKit
import Firebase
//UIViewController ADD IT IF PROBLEM WITH THE SCREEN
class FailedViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var country: UITextField!
    
    var pickerView: UIPickerView!
    var countryArrays = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_EN").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code : \(code)"
            
            countryArrays.append(name)
            countryArrays.sort(by: { (name1, name2) -> Bool in
                name1 < name2
                
        })
        
        
    }
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.black
        country.inputView = pickerView
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FailedViewController.dismissController))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
}

    //func numberOfComponentsInPickerView(_ pickerView: UIPickerView!) -> Int {}
    
    
    func dismissController(gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryArrays[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        country.text = countryArrays[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryArrays.count
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = NSAttributedString(string: countryArrays[row], attributes: [NSForegroundColorAttributeName: UIColor.white])
        return title
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
 
    @IBAction func registerButton(_ sender: Any) {
        if let emailText = email.text, let passwordText = password.text {
            FIRAuth.auth()?.createUser(withEmail: emailText, password:
                passwordText, completion: { (user, error) in
                    if let firebaseError = error {
                        print(firebaseError.localizedDescription)
                        let alert = UIAlertController(title: "Warning", message: "\(firebaseError.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) -> Void in
                        }))

                        self.present(alert, animated: true, completion: nil)
                        
                    } else {
                        
                        self.performSegue(withIdentifier: "Back",
                                          sender: self)
                        print("success")
                        
                    }
                    
            })
        }
    }
    
    
    
    @IBAction func backButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "Back",
                          sender: self)
        
    }
   
    


}
