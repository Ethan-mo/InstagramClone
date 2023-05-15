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
    
    var followButtonText: String {
        return user.isCurrentUser ? "프로필 편집" : (user.isFollowed ? "팔로잉" : "팔로우")
        
    }
    var followButtonBackgroundColor: UIColor {
        return user.isCurrentUser ? .white : (user.isFollowed ? .white : .systemBlue)
    }
    var followButtonTextColor: UIColor {
        return user.isCurrentUser ? .black : (user.isFollowed ? .red : .white)
    }
    
    init(user: User) {
        self.user = user
    }
}
