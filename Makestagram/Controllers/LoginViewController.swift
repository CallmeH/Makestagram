//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Pei Qin on 2018/7/11.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func loginButtonTapped(_ sender: UIButton) {
//        print("login button tapped")
        guard let authUI = FUIAuth.defaultAuthUI() else {return}
        authUI.delegate = self
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
    
}

extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) { //NBNOTE: did sign in with
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)") //assertions are only used in developmental stage
            return //what is this for?
        }
        guard  let user = authDataResult?.user else {return}
        let userRef = Database.database().reference().child("user").child(user.uid)
        userRef.observeSingleEvent(of: .value, with: {/*added unowned self*/[unowned self] (snapshot) in
//            if let userDict = snapshot.value as? [String: Any] { // snapshot value exists & of expected type
            if let userDict = User(snapshot: snapshot) {
                print("existing!\(userDict.username)")
            } else {
                self.performSegue(withIdentifier: "toCreateUsername", sender: self)//redirect to create username page
                print("Newbi!")
                // write uid into database
            }
            print("handled\(snapshot)")
        })//event closure to handle data passed back from the database
        //datasnapshot is an object that contains the data retrieved [dic, array, bool, num, string]
        print("handle user signup/login")

    }
}
