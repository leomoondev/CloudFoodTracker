//
//  ViewController.swift
//  FoodTracker
//
//  Created by Hyung Jip Moon on 2017-03-11.
//  Copyright © 2017 leomoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
// MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Handle the text field's user input through delegate callbacks.
        nameTextField.delegate = self
    }

    // MARK: UITextFieldDelegate
    
    // MARK: Actions
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text = "Default Text"
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        // Hide the keyboard.
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        mealNameLabel.text = textField.text
    }

}

