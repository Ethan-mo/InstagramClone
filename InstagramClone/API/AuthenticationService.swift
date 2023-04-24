//
//  AuthenticationService.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/24.
//

import UIKit
import Firebase

struct AuthCredentials{
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthenticationService {
    static func logInUser(email: String, password: String, compleion: @escaping(AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: compleion)
    }
    static func createUserAccount(withCredential credentials: AuthCredentials, completion: @escaping(Error?) -> Void) {
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                if let error = error {
                    print("계정 생성이 실패하였습니다.")
                    return
                }
                guard let uid = result?.user.uid else { return }
                let data: [String:Any] = ["email": credentials.email,
                                          "fullname": credentials.fullname,
                                          "profileImageUrl": imageUrl,
                                          "uid": uid,
                                          "username": credentials.username]
                userRef.document(uid).setData(data, completion: completion)
            }
        }
        
    }
}
