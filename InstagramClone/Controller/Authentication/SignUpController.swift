//
//  SignUpController.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/21.
//

import UIKit

class SignUpController: UIViewController {
    // MARK: - Properties
    let imagePicker = UIImagePickerController()
    var profileImage: UIImage?
    
    private var plusPushButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "plus_photo"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(selectProfileImageButton), for: .touchUpInside)
        return btn
    }()
    private var emailInputView: UIView = {
        let view = Utilities().inputContainerView(placeHolderText: "Email")
        return view
    }()
    private var passwordInputView: UIView = {
        let view = Utilities().inputContainerView(placeHolderText: "Password")
        return view
    }()
    private var fullnameInputView: UIView = {
        let view = Utilities().inputContainerView(placeHolderText: "Fullname")
        return view
    }()
    private var nicknameInputView: UIView = {
        let view = Utilities().inputContainerView(placeHolderText: "Nickname")
        return view
    }()
    private var signUpButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("회원가입", for: .normal)
        btn.setTitleColor(UIColor.systemPurple, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return btn
    }()
    private var moveToLogIn: UIButton = {
        let btn = Utilities().button("계정이 있으신가요? ", "로그인하기")
        return btn
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    // MARK: - Selectors
    @objc func selectProfileImageButton() {
        print("이미지를 선택해주세요.")
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    // MARK: - Helper
    func configureUI() {
        setGradientLayer()
        
        view.addSubview(plusPushButton)
        plusPushButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        plusPushButton.setDimensions(width: 128, height: 128)
        
        plusPushButton.layer.cornerRadius = 64
        
        let stack = UIStackView(arrangedSubviews: [emailInputView, passwordInputView, fullnameInputView, nicknameInputView, signUpButton])
        stack.axis = .vertical
        stack.spacing = 12
        view.addSubview(stack)
        stack.anchor(top: plusPushButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20 ,paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(moveToLogIn)
        moveToLogIn.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 12, paddingBottom: 40, paddingRight: 12)
    }
    func setGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
}

extension SignUpController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        
        plusPushButton.layer.cornerRadius = 64
        plusPushButton.layer.masksToBounds = true
        plusPushButton.imageView?.contentMode = .scaleAspectFit
        plusPushButton.imageView?.clipsToBounds = true
        plusPushButton.layer.borderColor = UIColor.white.cgColor
        plusPushButton.layer.borderWidth = 3
        
        self.plusPushButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true)
    }
    
}
