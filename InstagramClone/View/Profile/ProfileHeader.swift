//
//  ProfileHeader.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/27.
//

import UIKit
import Firebase
import SDWebImage

protocol ProfileHeaderDelegate: class {
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User)
}

class ProfileHeader: UICollectionReusableView {
    // MARK: - Properties
    
    var viewModel: ProfileHeaderViewModel? {
        didSet{
            print("viewData의 변화가 감지되었습니다.")
            updateData()
        }
    }
    
    weak var delegate: ProfileHeaderDelegate?

    private var profileImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "venom-7"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 40
        iv.setDimensions(width: 80, height: 80)
        return iv
    }()
    private let nameLabel: UILabel = {
       let lb = UILabel()
        lb.text = "사용자 이름"
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    }()

    private lazy var postsLabel: UILabel = {
       let lb = UILabel()
        lb.attributedText = attributedStatText(value: 2, label: "게시물")
        lb.numberOfLines = 0
        lb.textAlignment = .center
        return lb
    }()
    
    private lazy var followerLabel: UILabel = {
        let lb = UILabel()
        lb.attributedText = attributedStatText(value: 2, label: "팔로워")
        lb.numberOfLines = 0
        lb.textAlignment = .center
        return lb
    }()
    

    private lazy var followingLabel: UILabel = {
        let lb = UILabel()
        lb.attributedText = attributedStatText(value: 2, label: "팔로잉")
        lb.numberOfLines = 0
        lb.textAlignment = .center
        return lb
    }()
    private lazy var editProfileFollowButton: UIButton = {
        let btn = Utilities().customButton(text: "불러오는중...", backgroundColor: .white, textColor: .black)
        btn.addTarget(self, action: #selector(editProfileFollowButtonTapped), for: .touchUpInside)
        return btn
    }()

    private let storyHighLightLabel: UILabel = {
       let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.text = "스토리 하이라이트"
        return lb
    }()
    private var topDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
    private var bottomDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
    
    private lazy var gridButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "grid"), for: .normal)
        btn.addTarget(self, action: #selector(tappedGridButton), for: .touchUpInside)
        return btn
    }()
    private lazy var listButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "list"), for: .normal)
        btn.addTarget(self, action: #selector(tappedListButton), for: .touchUpInside)
        btn.tintColor = UIColor(white: 0, alpha: 0.2)
        return btn
    }()
    private lazy var bookmarkButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "ribbon"), for: .normal)
        btn.addTarget(self, action: #selector(tappedBookmarkButton), for: .touchUpInside)
        btn.tintColor = UIColor(white: 0, alpha: 0.2)
        return btn
    }()
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Selectors
    @objc func editProfileFollowButtonTapped() {
        guard let viewModel = viewModel else { return }
        delegate?.header(self, didTapActionButtonFor: viewModel.user)
    }

    @objc func tappedGridButton() {
        print("1")
    }
    @objc func tappedListButton() {
        print("2")
    }
    @objc func tappedBookmarkButton() {
        print("3")
    }
    // MARK: - API
    func followingUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let viewModel = self.viewModel else { return }
        UserService.addFollowMember(myUid: uid, otherUid: viewModel.uid) { user in
            print("Following하는 것에 성공했습니다.")
            self.viewModel?.user = user
        }
    }
    func unfollowingUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let viewModel = self.viewModel else { return }
        UserService.removeFollowMember(myUid: uid, otherUid: viewModel.uid) { user in
            print("UnFollowing하는 것에 성공했습니다.")
            self.viewModel?.user = user
        }
    }

    // MARK: - Helper
    func configureUI() {
        
        
        let mainStack = UIStackView(arrangedSubviews: [profileImageView ,postsLabel, followerLabel, followingLabel])
        mainStack.axis = .horizontal
        mainStack.alignment = .center
        mainStack.distribution = .equalCentering
        
        addSubview(mainStack)
        mainStack.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 20, paddingRight: 20)
        
        addSubview(nameLabel)
        nameLabel.anchor(top: mainStack.bottomAnchor, left: leftAnchor, paddingTop: 14, paddingLeft: 12)
        
        
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
//        addSubview(storyHighLightLabel)
//        storyHighLightLabel.anchor(top: buttonStack.bottomAnchor, left: leftAnchor, paddingTop: 80, paddingLeft: 12)
        
        
        let buttonStack2 = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        addSubview(buttonStack2)
        buttonStack2.axis = .horizontal
        buttonStack2.distribution = .fillEqually
        buttonStack2.anchor(top: editProfileFollowButton.bottomAnchor,left: leftAnchor, right: rightAnchor, paddingTop: 10, height: 50)

        addSubview(topDivider)
        topDivider.anchor(top:buttonStack2.topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
        
        addSubview(bottomDivider)
        bottomDivider.anchor(top:buttonStack2.bottomAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
    }
    
    func attributedStatText(value: Int, label: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font:UIFont.boldSystemFont(ofSize: 15)])
        attributedText.append(NSAttributedString(string: label, attributes: [.font:UIFont.systemFont(ofSize: 15)]))
        return attributedText
    }
    
    func updateData() {
        print("updateData가 실행되었습니다.")
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.nickname
        profileImageView.sd_setImage(with: URL(string: viewModel.profileImagestr))
        
        editProfileFollowButton.setTitle(viewModel.followButtonText, for: .normal)
        editProfileFollowButton.setTitleColor(viewModel.followButtonTextColor, for: .normal)
        editProfileFollowButton.backgroundColor = viewModel.followButtonBackgroundColor
        
        followerLabel.attributedText = attributedStatText(value: viewModel.user.userStats.followers, label: "팔로워")
        followingLabel.attributedText = attributedStatText(value: viewModel.user.userStats.following, label: "팔로잉")
        postsLabel.attributedText = attributedStatText(value: 0, label: "게시물")
    }
}
