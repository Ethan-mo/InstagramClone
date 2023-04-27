//
//  ProfileCell.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/27.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Helper
}
