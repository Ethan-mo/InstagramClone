//
//  UserViewModel.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/05/08.
//

import Foundation
import Firebase

struct UserViewModel {
    let user: User
    
    init(user: User) {
        self.user = user
    }
}
