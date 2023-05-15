//
//  Constant.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/24.
//

import Foundation
import Firebase


let REF = Firestore.firestore()
let USER_REF = REF.collection("users")
let FOLLOW_REF = REF.collection("user-followed")
let FOLLOWING_REF = REF.collection("user-following")

let COLLECTION_FOLLOWERS = REF.collection("followers")
let COLLECTION_FOLLOWING = REF.collection("following")


