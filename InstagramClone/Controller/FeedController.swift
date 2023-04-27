//
//  FeedController.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/17.
//

import UIKit
import Firebase

private let reuseIdentifier = "FeedCell"

protocol FeedControllerDelegate: class {
    func didRequestLogout()
}

class FeedController: UICollectionViewController {
    // MARK: - Properties
    weak var delegate: FeedControllerDelegate?
    // MARK: - Lifecycle
    override func viewDidLoad(){
        super.viewDidLoad()
        configureUI()
        configureNavigationUI()
    }
    
    // MARK: - Helper
    func configureUI() {
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    func configureNavigationUI() {
        navigationController?.navigationBar.backgroundColor = .systemGroupedBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(tappedLogout))
    }
    // MARK: - Seletors
    @objc func tappedLogout() {
        do{
            try Auth.auth().signOut()
            print("DEBUG: logout에 성공하였습니다.")
            delegate?.didRequestLogout()
            
            
            
        }catch let error{
            print("DEBUG: Failed to sign out with error\(error.localizedDescription)")
        }
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
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 110
        return CGSize(width: view.frame.width, height: height)
    }
}
