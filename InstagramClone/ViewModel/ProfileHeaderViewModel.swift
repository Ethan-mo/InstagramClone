//
//  ProfileHeaderViewModel.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/05/03.
//

import Foundation
import Firebase


struct ProfileHeaderViewModel {
    var user: User
    
    var uid: String {
        return user.uid
    }
    var email: String {
        return user.email
    }
    var fullname: String {
        return user.fullname
    }
    var nickname: String {
        return user.nickname
    }
    var profileImagestr: String {
        return user.profileImageStr
    }
    
    var followingCount: Int {
        return user.userRelationStats?.following ?? 0
    }
    var followersCount: Int {
        return user.userRelationStats?.followers ?? 0
    }
    
    var isMyAccount: Bool {
        guard let uid = Auth.auth().currentUser?.uid else { return false }
        if self.user.uid == uid {
            return true
        }
        return false
    }
    
    var isFollowed: Bool {
        return user.isFollowed
    }
    
    
    init(user: User) {
        self.user = user
    }
}
