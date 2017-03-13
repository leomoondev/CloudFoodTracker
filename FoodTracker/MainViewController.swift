//
//  MainViewController.swift
//  FoodTracker
//
//  Created by Hyung Jip Moon on 2017-03-13.
//  Copyright © 2017 leomoon. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - IBAction
    
    @IBAction func goToLoginButtonTapped(_ sender: UIButton) {
        
    }
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
                    print(json)
                    // handle json...
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
}
