//
//  UserCell.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/05/08.
//

import UIKit
class UserCell: UITableViewCell {
    // MARK: - Properties
    var userCellViewModel: UserCellViewModel? {
        didSet{
            configureViewModel()
        }
    }
    
    private lazy var profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 25
        iv.setDimensions(width: 50, height: 50)
        iv.clipsToBounds = true
        return iv
    }()
    private var nickNameLabel: UILabel = {
       let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = .black
        return lb
    }()
    private var fullNameLabel: UILabel = {
        let lb = UILabel()
         lb.font = UIFont.systemFont(ofSize: 16)
         lb.textColor = .gray
         return lb
    }()
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Helper
    func configureUI() {
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 15)
        
        let stack = UIStackView(arrangedSubviews: [nickNameLabel, fullNameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        
        addSubview(stack)
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 20)
        
    }
    func configureViewModel() {
        guard let viewModel = userCellViewModel else { return }
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        nickNameLabel.text = viewModel.nickname
        fullNameLabel.text = viewModel.fullname
    }
}
