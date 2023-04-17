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
       let iv = UIImageView(image: UIImage(systemName: "person"))
        iv.backgroundColor = .red
        iv.setDimensions(width: 30, height: 30)
        return iv
    }()
    private var nameLabel: UILabel = {
       let lb = UILabel()
        lb.backgroundColor = .yellow
        return lb
    }()
    private var menuButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .blue
        btn.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)
        return btn
    }()
    private var mainImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "cancel_shadow"))
        return iv
    }()
    private var likeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage( #imageLiteral(resourceName: "like_unselected"), for: .normal)
        btn.addTarget(self, action: #selector(handleLikeButton), for: .touchUpInside)
        return btn
    }()
    private var replyButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage( #imageLiteral(resourceName: "comment"), for: .normal)
        btn.addTarget(self, action: #selector(handleReplyButton), for: .touchUpInside)
        return btn
    }()
    private var messageButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage( #imageLiteral(resourceName: "send2"), for: .normal)
        btn.addTarget(self, action: #selector(handleMessageButton), for: .touchUpInside)
        return btn
    }()
    private var shareButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage( #imageLiteral(resourceName: "ribbon"), for: .normal)
        btn.addTarget(self, action: #selector(handleShareButton), for: .touchUpInside)
        return btn
    }()
    private var countLikeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "1 Like"
        return lb
    }()
    private var replyLogLable: UILabel = {
       let lb = UILabel()
        lb.text = "상현 안녕"
        return lb
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
    @objc func handleMenuButton() {
        
    }
    @objc func handleLikeButton() {
        
    }
    @objc func handleReplyButton() {
        
    }
    @objc func handleMessageButton() {
        
    }
    @objc func handleShareButton() {
        
    }
    // MARK: - Helper
    func configureUI() {
        let topStack = UIStackView(arrangedSubviews: [profileImageView, nameLabel, menuButton])
        topStack.axis = .horizontal
        topStack.alignment = .leading

        
        let bottomStack = UIStackView(arrangedSubviews: [likeButton, replyButton, menuButton, shareButton])
        bottomStack.axis = .horizontal
        let stack = UIStackView(arrangedSubviews: [topStack, mainImageView, bottomStack, countLikeLabel, replyLogLable])
        stack.axis = .vertical
        
        mainImageView.setDimensions(width: 300, height: 300)
        
        addSubview(stack)
        stack.anchor( top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
}
