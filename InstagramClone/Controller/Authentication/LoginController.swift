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
        let view = Utilities().inputContainerView(placeHolderText: "Email")
        return view
    }()
    private var passwordView: UIView = {
        let view = Utilities().inputContainerView(placeHolderText: "Password")
        return view
    }()
    private lazy var signInButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.setTitle("Log in", for: .normal)
        btn.backgroundColor = .systemPurple
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    private var stateLabel: UIButton = {
        let btn = Utilities().button("비밀번호를 잊으셨나요? ", "비밀번호 찾기")
        btn.addTarget(self, action: #selector(TappedSearchPassword), for: .touchUpInside)
        return btn
    }()
    private var moveToSignUpLabel: UIButton = {
        let btn = Utilities().button("계정이 없으신가요? ", "회원가입")
        btn.addTarget(self, action: #selector(TappedSignUp), for: .touchUpInside)
        return btn
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    // MARK: - Selectors
    @objc func TappedSearchPassword() {
        print("비밀번호 찾기를 누르셨습니다.")
    }
    
    @objc func TappedSignUp() {
        print("회원가입 버튼을 누르셨습니다.")
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
        
        view.addSubview(moveToSignUpLabel)
        moveToSignUpLabel.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 12, paddingBottom: 20, paddingRight: 12)
    }
    func setGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
    
}
