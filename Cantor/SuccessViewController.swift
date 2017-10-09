//
//  SuccessViewController.swift
//  Cantor
//
//  Created by Igor Kalinowski on 12.07.2017.
//  Copyright © 2017 Igor Kalinowski. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var userAmountTextField: UITextField!
    
    @IBOutlet weak var currencyButton: UIButton!
    
    @IBOutlet weak var exchangeLabel: UILabel!
    
    @IBOutlet weak var hideUserInputsButton: UIButton!
    
    @IBOutlet weak var currenciesPickerView: UIPickerView!
    
    @IBOutlet weak var updateDataLabel: UILabel!
    
    @IBOutlet weak var exchangeSecondLabel: UILabel!
    
    var selectedCurrencyCode: String?
    
    var cantor = Cantor()
    
    //krotka
    var result:(buy: Float, sell:Float) = (0.0, 0.0)
    
    // MARK: ViewController -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let defaults = UserDefaults.standard
        
        selectedCurrencyCode = defaults.string(forKey: "selectedCurrencyCode")
        
        if let code = selectedCurrencyCode {
            
            currencyButton.setTitle(code, for: [])
        }

        
        
        
        
        userAmountTextField.text = "100"
        
        actionExchange()
        actionExchangeSecond()
        showUpdateDate()
        
        
        
        
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SuccessViewController.action))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    
    
    
    //  MARK: Moje metody -
    
    
    
    
    func showUpdateDate() {
       
            
            let today = NSDate()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            
            updateDataLabel.text = dateFormatter.string(from: today as Date)
        }
        

    
    
    
    func actionExchangeSecond() {
        
        let amount = Float(Int(userAmountTextField.text!)!)
        
        if let code = selectedCurrencyCode {
            result = cantor.exchangeSecond(amount: amount, currencyCode: code)
        } else {
            var allCodes = [String](cantor.currencies.keys)
            
            if (allCodes.count > 0) {
                var code = allCodes[0]
                
                result = cantor.exchangeSecond(amount: amount, currencyCode: code)
            }
            
        }
        
        
        actionUpdateInterface()

    }
    
    
    
    func actionExchange() {
        
        let amount = Float(Int(userAmountTextField.text!)!)
        
        if let code = selectedCurrencyCode {
        result = cantor.exchange(amount: amount, currencyCode: code)
        } else {
            var allCodes = [String](cantor.currencies.keys)
            
            if (allCodes.count > 0) {
                var code = allCodes[0]
                
                result = cantor.exchange(amount: amount, currencyCode: code)
            }
            
        }
       
        
        actionUpdateInterface()
        
    }
    
    
    @IBAction func actionShowCurrenciesView(_ sender: Any) {
        currenciesPickerView.isHidden = false
        
    }
    
    @IBAction func action(_ sender: Any) {
        userAmountTextField.resignFirstResponder()
        
        currenciesPickerView.isHidden = true
    }
    @IBAction func actionUserAmountChanged(_ sender: Any) {
        actionExchange()
       
    }
    @IBAction func actionUpdateInterface() {
        var displayResult: Float = 0.0
        
        if (segmentedControl.selectedSegmentIndex == 0) {
            displayResult = result.sell
        }
        else {
            displayResult = result.buy
        }
        
        let number = NSNumber(value: displayResult)
        
        exchangeLabel.text = cantor.currencyFormatter.string(from: number)
        
        exchangeSecondLabel.text = cantor.currencyFormatter.string(from: number)
        
    }
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "Back", sender: self)
    }
   
    
    //MARK: UITextFieldDelegate Methods -
   
    /*
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        
    }
 */
    
    // MARK: UIPickerView Methods - 
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cantor.currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var allCodes = [String](cantor.currencies.keys)
        let code = allCodes[row]
        
        if let currency = cantor.currencies[code] {
            return "\(currency.name) (\(currency.code))"
        }
        
        
        
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        var allCodes = [String](cantor.currencies.keys)
        
        
        selectedCurrencyCode = allCodes[row]
        
        if let code = selectedCurrencyCode {
            
            let defaults = UserDefaults.standard
            
            defaults.set(code, forKey: "selectedCurrencyCode")
            defaults.synchronize()
            
            currencyButton.setTitle(code, for: [])
            
            actionExchange()
        }
    }
    
    
}
