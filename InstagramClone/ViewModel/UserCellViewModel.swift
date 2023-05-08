//
//  UserViewModel.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/05/08.
//

import Foundation
import Firebase

struct UserCellViewModel {
    private let user: User
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageStr)
    }
    
    var fullname: String {
        return user.fullname
    }
    
    var nickname: String {
        return user.nickname
    }
    
    init(user: User) {
        self.user = user
    }
}
