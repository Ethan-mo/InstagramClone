//
//  UserService.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/24.
//

import UIKit
import Firebase

struct UserService {
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        USER_REF.document(uid).getDocument { snapshot, error in
            print("유저 정보를 불러왔습니다. \(snapshot?.data())")
            guard let dictionaty = snapshot?.data() as? [String:AnyObject] else { return }
            let user = User(dictionary: dictionaty)
            print("성공")
            completion(user)
        }
    }
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        var users = [User]()
        USER_REF.getDocuments { snapshot, error in
            if let error = error {
                print("Error: 유저들의 정보를 불러오지 못했습니다.")
            }
            guard let snapshots = snapshot?.documents else { return }
            for document in snapshots {
                guard let dictionary = document.data() as? [String:AnyObject] else { return }
                let user = User(dictionary: dictionary)
                users.append(user)
                print("유저 정보들을 성공적으로 불러왔습니다.")
                completion(users)
            }
        }
    }
}

struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        ref.putData(imageData) { metadata, error in
            if let error = error {
                print("DEBUG: 이미지 업로드에 실패하였습니다. \(error.localizedDescription)")
                return
            }
            ref.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
}

