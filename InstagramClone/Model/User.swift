//
//  User.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/24.
//

import UIKit

struct User {
    var uid: String
    var email: String
    var fullname: String
    var nickname: String
    var profileImageStr: String = ""
    
    init(dictionary: [String: AnyObject]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.nickname = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        
        if let profileImageUrlString = dictionary["profileImageUrl"] as? String {
            self.profileImageStr = profileImageUrlString
        }
    }
}
