//
//  FeedController.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/17.
//

import UIKit
private let reuseIdentifier = "FeedCell"

class FeedController: UICollectionViewController {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad(){
        super.viewDidLoad()
        configureUI()
        
    }
    // MARK: - Helper
    func configureUI() {
        collectionView.backgroundColor = .systemPurple
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}
// MARK: - UICollectionViewDataSource
extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        return cell
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 500)
    }
}
