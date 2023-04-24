//
//  Utilities.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/21.
//

import UIKit
class Utilities{
    func inputContainerView(placeHolderText: String, textField: UITextField = UITextField()) -> UIView{
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.layer.cornerRadius = 5
        
        
        textField.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray6])
        textField.textColor = .white
        textField.autocorrectionType = .no
        view.addSubview(textField)
        textField.anchor(top:view.topAnchor,left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 12)
        
        return view
    }
    func button(_ descriptionLabel: String, _ title: String) -> UIButton{
        let btn = UIButton(type: .system)
        
        /// 하이퍼링크 라벨형 버튼 제작
        let attributedTitle = NSMutableAttributedString(string: descriptionLabel, attributes: [NSMutableAttributedString.Key.font: UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor(white:1 ,alpha: 0.87)])
        attributedTitle.append(NSMutableAttributedString(string: title, attributes: [NSMutableAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor(white:1 ,alpha: 0.87)]))
        btn.setAttributedTitle(attributedTitle, for: .normal)
        return btn
    }
}
