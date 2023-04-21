//
//  LoginController.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/21.
//

import UIKit

class LoginController: UIViewController {
    // MARK: - Properties
    private let logoImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        return iv
    }()
    private var emailView:UIView  = {
        let view = Utilities().inputContainerView(placeHolderText: "ID를 입력해주세요.")
        return view
    }()
    private var passwordView: UIView = {
        let view = Utilities().inputContainerView(placeHolderText: "PassWord를 입력해주세요.")
        return view
    }()
    private lazy var signInButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.setTitle("Login", for: .normal)
        btn.backgroundColor = .systemPurple
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    private var stateLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        return lb
    }()
    private var moveToSignUpLabel: UILabel = {
       let lb = UILabel()
        lb.textColor = .white
        return lb
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    // MARK: - Helper
    func configureUI() {
        setGradientLayer()
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 80)
        
        let stack = UIStackView(arrangedSubviews: [emailView, passwordView, signInButton, stateLabel])
        stack.axis = .vertical
        stack.spacing = 12
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 20, paddingRight: 20)
    }
    func setGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
    
}
