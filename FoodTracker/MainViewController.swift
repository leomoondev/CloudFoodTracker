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
        
        let userNameValue = userNameTextField.text
        
        if isStringEmpty(userNameValue!) == true {
            return
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
