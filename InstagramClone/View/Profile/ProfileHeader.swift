//
//  ProfileHeader.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/27.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemMint
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
