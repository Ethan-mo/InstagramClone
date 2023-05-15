//
//  User.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/24.
//

import UIKit
import Firebase

struct User {
    var uid: String
    var email: String
    var fullname: String
    var nickname: String
    var profileImageStr: String = ""
    var isFollowed: Bool = false
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid }
    var userRelationStats: UserRelationStats?
    
    
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

struct UserRelationStats {
    var followers: Int
    var following: Int
}
