//
//  UserService.swift
//  Makestagram
//
//  Created by Pei Qin on 2018/7/12.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct UserService {
    //user-related networking code
    static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void) {
        let userSetName = ["username": username]
        let ref = Database.database().reference().child("user").child(firUser.uid)
        
        ref.setValue(userSetName) { (error, reference) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            } else {
                ref.observeSingleEvent(of: .value, with: { (snapshot) in
                    let user = User(snapshot: snapshot)
                    //handle user further here
                    print(user?.username)
                    completion(user)
                })
            }
        }
    }
    static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            if let userInstance = User(snapshot: snapshot) {
                return completion(userInstance)
            } else {
                return completion(nil)
            }
        })
        
        
        
    }
}
