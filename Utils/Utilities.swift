//
//  Utilities.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/21.
//

import UIKit
class Utilities{
    func inputContainerView(placeHolderText: String) -> UIView{
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.layer.cornerRadius = 5
        
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray6])
        tf.textColor = .white
        tf.autocorrectionType = .no
        view.addSubview(tf)
        tf.anchor(top:view.topAnchor,left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 12)
        
        return view
    }
    func button(_ descriptionLabel: String, _ title: String) -> UIButton{
        let btn = UIButton(type: .system)
        
        /// 하이퍼링크 라벨형 버튼 제작
        let attributedTitle = NSMutableAttributedString(string: descriptionLabel, attributes: [NSMutableAttributedString.Key.font: UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSMutableAttributedString(string: title, attributes: [NSMutableAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor.white]))
        btn.setAttributedTitle(attributedTitle, for: .normal)
        return btn
    }
}
