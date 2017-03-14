//
//  MainViewController.swift
//  FoodTracker
//
//  Created by Hyung Jip Moon on 2017-03-13.
//  Copyright © 2017 leomoon. All rights reserved.
//

import UIKit
import Security

let kSecClassGenericPasswordValue = String(format: kSecClassGenericPassword as String)
let kSecClassValue = String(format: kSecClass as String)
let kSecAttrServiceValue = String(format: kSecAttrService as String)
let kSecValueDataValue = String(format: kSecValueData as String)
let kSecMatchLimitValue = String(format: kSecMatchLimit as String)
let kSecReturnDataValue = String(format: kSecReturnData as String)
let kSecMatchLimitOneValue = String(format: kSecMatchLimitOne as String)
let kSecAttrAccountValue = String(format: kSecAttrAccount as String)

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    // MARK: - Properties
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - IBAction
    @IBAction func signUpButtonTapped(_ sender: AnyObject) {
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        
        let parameters = ["username": userNameTextField.text!, "password": passwordTextField.text!] as Dictionary<String, String>
        
        //create the url with URL
        let url = URL(string: "http://159.203.243.24:8000/signup")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
//                    let keys = Array(json.keys)
//                    print(keys)
                    
                    let values = Array(json.values)
                    
                    print(values)
          
                    if (json["error"] != nil)  {
                        
                        let showTitle = values[0] as! String
                        
                        OperationQueue.main.addOperation{
                            let alert = UIAlertController(title: showTitle, message: "Please try it again with different username", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    else {
                        let currentConditions = json["user"] as! [String:Any]
                        
                        for (key, value) in currentConditions {
                            self.setPasscode(passcode: "\(key) - \(value) ")
                            print(self.getPasscode())
                            
                            print("\(key) - \(value) ")
                        }
                        
                        OperationQueue.main.addOperation{
                            let alert = UIAlertController(title: "Registration Success", message: "You have successfully registered", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            } catch let error {
                
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func setPasscode(passcode: String) {
        let keychainAccess = KeychainAccess();
        keychainAccess.setPasscode(identifier: "username", passcode:passcode);
    }
    
    func getPasscode() -> NSString {
        let keychainAccess = KeychainAccess();
        return keychainAccess.getPasscode(identifier: "username")! as NSString;
    }
    
    
    func deletePasscode() {
        let keychainAccess = KeychainAccess();
        keychainAccess.setPasscode(identifier: "username", passcode:"");
    }
    
    struct KeychainAccess {
        
        func setPasscode(identifier: String, passcode: String) {
            if let dataFromString = passcode.data(using: String.Encoding.utf8) {
                let keychainQuery = [
                    kSecClassValue: kSecClassGenericPasswordValue,
                    kSecAttrServiceValue: identifier,
                    kSecValueDataValue: dataFromString
                    ] as CFDictionary
                SecItemDelete(keychainQuery)
                print(SecItemAdd(keychainQuery, nil))
            }
        }
        
        func getPasscode(identifier: String) -> String? {
            let keychainQuery = [
                kSecClassValue: kSecClassGenericPasswordValue,
                kSecAttrServiceValue: identifier,
                kSecReturnDataValue: kCFBooleanTrue,
                kSecMatchLimitValue: kSecMatchLimitOneValue
                ] as  CFDictionary
            var dataTypeRef: AnyObject?
            let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
            var passcode: String?
            if (status == errSecSuccess) {
                if let retrievedData = dataTypeRef as? Data,
                    let result = String(data: retrievedData, encoding: String.Encoding.utf8) {
                    passcode = result as String
                    
                    print(result)
                }
            }
            else {
                print("Nothing was retrieved from the keychain. Status code \(status)")
            }
            return passcode
        }
        

    }
}
