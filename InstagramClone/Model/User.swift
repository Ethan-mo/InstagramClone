//
//  User.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/24.
//

import UIKit

class User {
    var uid: String
    var email: String
    var fullname: String
    var nickname: String
    var profileImageStr: String
    init(uid: String,email: String, fullname: String, nickname: String, profileImageStr: String) {
        self.uid = uid
        self.email = email
        self.fullname = fullname
        self.nickname = nickname
        self.profileImageStr = profileImageStr
    }
}
