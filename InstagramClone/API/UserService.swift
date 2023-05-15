//
//  UserService.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/24.
//

import UIKit
import Firebase

typealias FirestoreCompletion = (Error?) -> Void

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
    static func fetchOtherUser(uid:String,completion: @escaping(User) -> Void) {
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
                var user = User(dictionary: dictionary)                
                users.append(user)
            }
            print("유저 정보들을 성공적으로 불러왔습니다.")
            completion(users)
        }
    }
    static func getFollowMember(myUid: String, completion: @escaping([User]) -> Void) {
        var users = [User]()
        FOLLOWING_REF.document(myUid).getDocument { snapshot, error in
            if let snapshot = snapshot, snapshot.exists {
                let fieldDictionary = snapshot.data() as? [String:Any]
                for key in fieldDictionary!.keys {
                    fetchOtherUser(uid: key) { user in
                        users.append(user)
                    }
                }
                completion(users)
                
            } else {
                print("팔로잉한 유저를 가져오는데 실패했습니다.")
            }
            if let error = error {
                print("팔로잉한 유저를 가져오는데 실패했습니다.")
            }
        }
    }
    
    static func follow(uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]) { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-follower").document(currentUid).setData([:],completion: completion)
        }
    }
    static func unfollow(uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-follower").document(currentUid).delete(completion: completion)
        }
    }
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument { snapshot, error in
            guard let isFollowed = snapshot?.exists else { return }
            completion(isFollowed)
        }
    }
    
    
    /// 팔로우 버튼을 눌렀을 때 사용
    /// - Parameters:
    ///   - myUid: 내 Uid로, Firestroe에서 내 document(user-following)에 접근할 때와, 상대편의 document(user-followed)에 저장할 Data를 남길 때 사용한다.
    ///   - otherUid: 상대편의 Uid로 위 설명과 같다.
    ///   - completion: 나의 uid와 상대편의 uid를 통해서 서로의 document에 팔로잉, 팔로우 기록을 남길 수 있다.
    static func addFollowMember(myUid: String, otherUid: String, completion: @escaping(User) -> Void) {
        FOLLOWING_REF.document(myUid).setData([otherUid: true], merge: true) { error in
            if let error = error {
                print("나의 Following작업에 문제가 발생했습니다.")
            }
            FOLLOW_REF.document(otherUid).setData([myUid: true], merge: true) { error in
                if let error = error {
                    print("상대방의 Followed 기록 작업에 문제가 발생했습니다.")
                }
                
                fetchOtherUser(uid: otherUid, completion: completion)
            }
        }
    }
    static func removeFollowMember(myUid: String, otherUid: String, completion: @escaping(User) -> Void) {
        let docRef = FOLLOWING_REF.document(myUid)
        var updateData = [otherUid: FieldValue.delete()]
        FOLLOWING_REF.document(myUid).updateData(updateData) { error in
            if let error = error {
                print("나의 Following기록을 삭제하는 것에 문제가 발생했습니다.")
            }
            updateData = [myUid:FieldValue.delete()]
            FOLLOW_REF.document(myUid).updateData(updateData) { error in
                if let error = error {
                    print("나의 Following기록을 삭제하는 것에 문제가 발생했습니다.")
                }
                fetchOtherUser(uid: otherUid, completion: completion)
            }
        }
    }
    static func getFollowingMembers(completion: @escaping([String]) -> Void ) {
        // Firestore에서 해당 사용자의 Following 멤버들을 조회하는 로직 구현
        // ...
        var followingUids = [String]()
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        FOLLOWING_REF.document(currentUid).getDocument { snapshot, error in
            if let snapshot = snapshot, snapshot.exists {
                let fieldDictionary = snapshot.data() as? [String:Any]
                print(Array(fieldDictionary!.keys))
                completion(Array(fieldDictionary!.keys))
            } else {
                print("팔로잉한 유저들의 UID를 가져오는데 실패했습니다.")
            }
        }
    }
    static func getFollowing_FollowedMemberCount(uid:String, completion: @escaping(Int, Int) -> Void ) {
        // Firestore에서 해당 사용자의 Following 멤버들을 조회하는 로직 구현
        // ...
        var followingUids = [String]()
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        FOLLOWING_REF.document(uid).getDocument { snapshot, error in
            if let snapshot = snapshot, snapshot.exists {
                let fieldDictionary = snapshot.data() as? [String:Any]
                let followingMembers = Array(fieldDictionary!.keys)
                FOLLOW_REF.document(uid).getDocument { followedSnapshot, error in
                    if let followedSnapshot = followedSnapshot, followedSnapshot.exists {
                        let followedFieldDictionary = followedSnapshot.data() as? [String:Any]
                        let followedMembers = Array(followedFieldDictionary!.keys)
                        completion(followingMembers.count,followedMembers.count)
                        
                    } else {
                        print("나를 팔로한 유저들의 UID를 가져오는데 실패했습니다.")
                    }
                }
                
            } else {
                print("내가 팔로잉한 유저들의 UID를 가져오는데 실패했습니다.")
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

