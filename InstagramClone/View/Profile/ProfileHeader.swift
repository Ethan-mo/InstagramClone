//
//  ProfileHeader.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/27.
//

import UIKit
import SDWebImage


class ProfileHeader: UICollectionReusableView {
    // MARK: - Properties
    
    var viewModel: ProfileHeaderViewModel? {
        didSet{
            print("Header지역 입니다.")
            updateData()
        }
    }

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
    private lazy var editProfileButton: UIButton = {
        let btn = Utilities().customButton(text: "프로필 편집", backgroundColor: .white, textColor: .black)
        btn.addTarget(self, action: #selector(editProfileButtonTapped), for: .touchUpInside)
        return btn
    }()
    private lazy var shareProfileButton: UIButton = {
        let btn = Utilities().customButton(text: "프로필 공유", backgroundColor: .white, textColor: .black)
        btn.addTarget(self, action: #selector(shareProfileButtonTapped), for: .touchUpInside)
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
    @objc func editProfileButtonTapped() {
        print("프로필 편집 버튼이 눌렸습니다.")
    }
    @objc func shareProfileButtonTapped() {
        print("프로필 공유 버튼이 눌렸습니다.")
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
        
        
        let buttonStack = UIStackView(arrangedSubviews: [editProfileButton])//, shareProfileButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 8
        buttonStack.distribution = .fillEqually
        
        addSubview(buttonStack)
        buttonStack.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
//        addSubview(storyHighLightLabel)
//        storyHighLightLabel.anchor(top: buttonStack.bottomAnchor, left: leftAnchor, paddingTop: 80, paddingLeft: 12)
        
        
        let buttonStack2 = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        addSubview(buttonStack2)
        buttonStack2.axis = .horizontal
        buttonStack2.distribution = .fillEqually
        buttonStack2.anchor(top: buttonStack.bottomAnchor,left: leftAnchor, right: rightAnchor, paddingTop: 10, height: 50)

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
        nameLabel.text = viewModel?.nickname
        profileImageView.sd_setImage(with: URL(string: viewModel!.profileImagestr))
    }
}
