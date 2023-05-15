//
//  ProfileController.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/17.
//

import UIKit

private let cellIdentifier = "ProfileCell"
private let headerIdentifier = "ProfileHeader"


class ProfileController: UICollectionViewController {
    // MARK: - Properties
    private var user: User
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        // ProfileController에서 핵심적으로 사용되는 User Data의 값을 불러온다.
        /// 지금 가져올 Data는, 기본적인 User Model에는 없는, 즉, FetchUsers Api로는 가져올 수 없는 Data이기 때문에, 지금 가져온다.
        checkIfUserIsFollowed(uid: user.uid)
        // ProfileController의 기본 구조를 설정
        configureCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfUserIsFollowed(uid: user.uid)
    }
    
    // MARK: - API
    func getFollowingMembers() { // 강의가 아닌, 내가 생각했던 방법
        UserService.getFollowingMembers { uids in
            if uids.contains(self.user.uid) {
                self.user.isFollowed = true
                
            }else {
                self.user.isFollowed = false
            }
            self.collectionView.reloadData()
        }
    }
    func follow(uid:String) {
        UserService.follow(uid: uid) { error in
            print("[ProfileController]- 해당 유저를 팔로우했습니다.")
            self.user.isFollowed = true
            self.collectionView.reloadData()
        }
    }
    func unfollow(uid: String) {
        UserService.unfollow(uid: uid) { error in
            print("[ProfileController]- 해당 유저를 언팔로우했습니다.")
            self.user.isFollowed = false
            self.collectionView.reloadData()
        }
    }
    func checkIfUserIsFollowed(uid: String) {
        UserService.checkIfUserIsFollowed(uid: uid) { isFollowed in
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Helper
    func configureCollectionView() {
        navigationItem.title = user.nickname
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
}

// MARK: - UICollectionViewDataSource
extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        15
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProfileCell
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        header.delegate = self
        header.viewModel = ProfileHeaderViewModel(user: user)
        
        return header
    }
}
// MARK: - UICollectionViewDelegate
extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell을 선택하셨습니다.")
    }
}
// MARK: - UICollectionViewFlowLayout
extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}
// MARK: - ProfileHeaderDelegate
extension ProfileController: ProfileHeaderDelegate {
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User) {
        if user.isCurrentUser {
            print("프로필 편집 버튼을 눌렀습니다.")
        }else if user.isFollowed {
            print("언팔로우 버튼을 눌렀습니다.")
            unfollow(uid: user.uid)
        }else {
            print("팔로우 버튼을 눌렀습니다.")
            follow(uid: user.uid)
        }
    }
}
