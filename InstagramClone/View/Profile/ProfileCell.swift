//
//  ProfileCell.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/27.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    // MARK: - Properties
    private var postThumbnailImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "venom-7"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true // 사실상 설정하지 않아도, true이다. 하지만 햇갈릴 수 있는 부분은, 일반적인 UIView는 모두 clipToBounds의 속성값이 false이므로, UIImageView의 기본값이 true임을 주의해서 사용해야한다.
        return iv
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        backgroundColor = .lightGray
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Helper
    func configureUI() {
        contentView.addSubview(postThumbnailImage)
        postThumbnailImage.anchor(top:topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
}
