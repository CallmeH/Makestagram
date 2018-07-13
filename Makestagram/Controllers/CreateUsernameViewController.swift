//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Pei Qin on 2018/7/12.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        //create or retrieve account
        guard let newUser = Auth.auth().currentUser, let nameField = usernameTextField.text, !nameField.isEmpty else {
            print("cannot have empty username")
            return
        }
        UserService.create(newUser, username: nameField) { (userHere) in
            guard let i = userHere else {return}
            print("Created new:\(i.username)")
            
            User.setCurrent(i)
            
            let initialViewController = UIStoryboard.initializeViewController(for: UIStoryboard.MGType.login)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
        
    }
    
    
}
