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
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        view.addSubview(tf)
        tf.anchor(top:view.topAnchor,left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 12)
        
        return view
    }
}
