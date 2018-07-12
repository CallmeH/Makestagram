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
        let userSetName = ["username": nameField]
        let ref = Database.database().reference().child("user").child(newUser.uid)
        
        ref.setValue(userSetName) { (error, reference) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            } else {
                ref.observeSingleEvent(of: .value, with: { (snapshot) in
                    let user = User(snapshot: snapshot)
                    //handle user further here
                    print(user?.username)
                    })
            }
        }
        
    }
    
    
}
