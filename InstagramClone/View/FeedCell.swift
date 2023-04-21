//
//  FeedCell.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/18.
//

import UIKit

class FeedCell: UICollectionViewCell {
    // MARK: - Properties
    private lazy var profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "venom-7")
        return iv
    }()
    private lazy var nameButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("venom", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(didTapUserName), for: .touchUpInside)
        return btn
    }()
    private var menuButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .black
        btn.setImage(UIImage(systemName: "server.rack"), for: .normal)
        btn.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)
        return btn
    }()
    private var mainImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "venom-7"))
        return iv
    }()
    private var likeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .black
        btn.setImage( #imageLiteral(resourceName: "like_unselected"), for: .normal)
        btn.addTarget(self, action: #selector(handleLikeButton), for: .touchUpInside)
        return btn
    }()
    private var replyButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .black
        btn.setImage( #imageLiteral(resourceName: "comment"), for: .normal)
        btn.addTarget(self, action: #selector(handleReplyButton), for: .touchUpInside)
        return btn
    }()
    private var shareButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .black
        btn.setImage( #imageLiteral(resourceName: "send2"), for: .normal)
        btn.addTarget(self, action: #selector(handleShareButton), for: .touchUpInside)
        return btn
    }()
    private var saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .black
        btn.setImage( #imageLiteral(resourceName: "ribbon"), for: .normal)
        btn.addTarget(self, action: #selector(handleSaveButton), for: .touchUpInside)
        return btn
    }()
    private var countLikeLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 13)
        lb.text = "1 Like"
        return lb
    }()
    private var replyLogLable: UILabel = {
       let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 14)
        lb.text = "상현 안녕"
        return lb
    }()
    private var postTimeLabel: UILabel = {
       let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textColor = .lightGray
        lb.text = "2 day ago"
        return lb
    }()
    private let divLine: UIView = {
       let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemPurple
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Selector
    @objc func didTapUserName() {
         print("유저이름을 선택")
    }
    @objc func handleMenuButton() {
        print("메뉴를 선택")
    }
    @objc func handleLikeButton() {
        print("좋아요을 선택")
    }
    @objc func handleReplyButton() {
        print("댓글을 선택")
    }
    @objc func handleSaveButton() {
        print("저장을 선택")
    }
    @objc func handleShareButton() {
        print("공유를 선택")
    }
    // MARK: - Helper
    func configureUI() {
        
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        profileImageView.setDimensions(width: 40, height: 40)
        profileImageView.layer.cornerRadius = 20
        
        addSubview(nameButton)
        nameButton.centerY(inView: profileImageView,leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
        addSubview(menuButton)
        menuButton.centerY(inView: profileImageView)
        menuButton.anchor(right: rightAnchor, paddingRight: 8)
        
        addSubview(mainImageView)
        mainImageView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 12)
        mainImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [likeButton, replyButton, shareButton])
        stack.axis = .horizontal
        stack.spacing = 16
        addSubview(stack)
        stack.anchor(top: mainImageView.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        
//        addSubview(likeButton)
//        likeButton.anchor(top: mainImageView.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
//
//        addSubview(replyButton)
//        replyButton.anchor(top: likeButton.topAnchor, left: likeButton.rightAnchor, paddingLeft: 8)
//
//        addSubview(shareButton)
//        shareButton.anchor(top:likeButton.topAnchor, left: replyButton.rightAnchor, paddingLeft: 8)
        
        addSubview(saveButton)
        saveButton.anchor(top: stack.topAnchor, right: rightAnchor, paddingRight: 12)

        addSubview(countLikeLabel)
        countLikeLabel.anchor(top: stack.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 12)
        
        addSubview(replyLogLable)
        replyLogLable.anchor(top: countLikeLabel.bottomAnchor, left: leftAnchor, paddingTop: 3, paddingLeft: 12)

        addSubview(postTimeLabel)
        postTimeLabel.anchor(top: replyLogLable.bottomAnchor, left: leftAnchor, paddingTop: 3, paddingLeft: 12)
        
        addSubview(divLine)
        divLine.anchor(top: postTimeLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8)
    }
}
