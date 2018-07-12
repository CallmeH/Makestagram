//
//  User.swift
//  Makestagram
//
//  Created by Pei Qin on 2018/7/12.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class User {
    let uid: String
    let username: String
    
    init(uida: String, userNamea: String) {
        self.uid = uida
        self.username = userNamea
    }
    
    init?(snapshot: DataSnapshot) {//failable, if fail, say, no uid, return nil
        guard let dict = snapshot.value as? [String: Any], let userName = dict["username"] as? String else {return nil} // snapshot is dictionary & user has an existing uid
        self.uid = snapshot.key //key of the location for this snapshot
        self.username = userName
    }
}
