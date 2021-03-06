//
//  PhoneAndCountryCodeVC.swift
//  ES_UIPresentationController_Demo
//
//  Created by Reid Chatham on 9/8/15.
//  Copyright © 2015 Hermes Messenger LLC. All rights reserved.
//

import UIKit


public class PhoneAndCountryCodeViewController<T:Loggable> : ESModalViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Country code property
    var countryCode: Int?
    
    var pickerData : [String] {
        return countryCodeData.keys.sort(<)
    }
    
    var existingUserCheck: ((T, (Bool) -> Void) -> Void)?
    
    
    @IBOutlet weak var phoneNumberTextField: UITextField! {
        didSet {
            phoneNumberTextField.delegate = self
        }
    }
    
    @IBOutlet weak var countryCodeTextField: UITextField! {
        didSet {
            countryCodeTextField.delegate = self
            
            let pickerView = UIPickerView()
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.backgroundColor = UIColor.whiteColor()
            
            countryCodeTextField.inputView = pickerView
        }
    }
    
    var loginController : LoginController!
    
    convenience public init(){
        let frameworkBundle = NSBundle(forClass: self.dynamicType)
        self.init(nibName: "PhoneAndCountryCodeVC", bundle: frameworkBundle)
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        ESPresentationManager.sharedInstance.presentationController?.changeSize()
        //preferredContentSize = modalPresentationSize()
    }
    
    override public func modalPresentationSize()->CGSize{
        return CGSizeMake(300, 500)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func goToTwoFVerificationVC(sender: AnyObject) {
        
        if countryCode != nil && !phoneNumberTextField.text!.isEmpty {
            let phoneNumber = phoneNumberTextField.text!
            
            let completePhoneNumber = (countryCode!, phoneNumber)
            print("Complete phone number: \(completePhoneNumber)")
            
            var numbers: [Character] = []
            for character in phoneNumber.characters { numbers.append(character) }
            print(numbers.count)
            
            if numbers.count >= 10 {
                loginController.didEnter(phoneNumber: phoneNumberTextField.text!, withCountryCode: countryCode!)
                
                let verificationVC = VerificationViewController<T>()
                verificationVC.loginController = loginController
                verificationVC.existingUserCheck = existingUserCheck
                verificationVC.view.backgroundColor = view.backgroundColor
                
                navigationController?.pushViewController(verificationVC, animated: true)
            }
        }
        
    }
    @IBAction func cancelButtonPressed(sender: UIButton) {
        ESPresentationManager.sharedInstance.presentationController?.dismissModal()
    }
    
    
    //UIPicker methods//////////////
    
    public func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let item = pickerData[row]
        
        let attributes : [String : AnyObject]? = nil
        
        //LEARN HOW ATTRIBUTED STRINGS WORK
        
        let attributedString = NSAttributedString(string: item, attributes: attributes)
        
        return attributedString
    }
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = pickerData[row]
        
        return item
    }
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerData.count
    }
    
    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let item = pickerData[row]
        
        countryCodeTextField.text = item
        
        for country in countryCodeData.keys {
            if item == country {
                self.countryCode = countryCodeData[country]
                print("Country code: \(self.countryCode!)")
                
            }
        }
    }
    
    // Text Field methods
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        phoneNumberTextField.resignFirstResponder()
        countryCodeTextField.resignFirstResponder()
        return true
    }
    
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    let countryCodeData = [
        "Afghanistan - +93" : 93,
        "Albania - +355" : 355,
        "Algeria - +213" : 213,
        "American Samoa - +1 684" : 1684,
        "Andorra - +376" : 376,
        "Angola - +244" : 244,
        "Anguilla - +1 264" : 1264,
        "Antarctica - +672" : 672,
        "Antigua and Barbuda - +1 268" : 1268,
        "Argentina - +54" : 54,
        "Armenia - +374" : 374,
        "Aruba - +297" : 297,
        "Australia - +61" : 61,
        "Austria - +43" : 43,
        "Azerbaijan - +994" : 994,
        "Bahamas - +1 242" : 242,
        "Bahrain - +973" : 973,
        "Bangladesh - +880" : 880,
        "Barbados - +1 246" : 1246,
        "Belarus - +375" : 385,
        "Belgium - +32" : 32,
        "Belize - +501" : 501,
        "Benin - +229" : 229,
        "Bermuda - +1 441" : 1441,
        "Bhutan - +975" : 975,
        "Bolivia - +591" : 591,
        "Bosnia and Herzegovina - +387" : 387,
        "Botswana - +267" : 267,
        "Brazil - +55" : 55,
        "British Virgin Islands - +1 284" : 1284,
        "Brunei - +673" : 673,
        "USA - +1" : 1
    ]
}