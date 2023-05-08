//
//  SignUpController.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/21.
//

import UIKit

class SignUpController: UIViewController {
    // MARK: - Properties
    weak var delegate: AuthenticationDelegate?
    
    let imagePicker = UIImagePickerController()
    var profileImage: UIImage?
    
    private var plusPushButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "plus_photo"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(selectProfileImageButton), for: .touchUpInside)
        return btn
    }()
    private lazy var emailInputView: UIView = {
        let view = Utilities().inputContainerView(placeHolderText: "Email",textField: emailTextField)
        return view
    }()
    private lazy var passwordInputView: UIView = {
        let view = Utilities().inputContainerView(placeHolderText: "Password", textField: passwordTextField)
        return view
    }()
    private lazy var fullnameInputView: UIView = {
        let view = Utilities().inputContainerView(placeHolderText: "Fullname", textField: fullnameTextField)
        return view
    }()
    private lazy var nicknameInputView: UIView = {
        let view = Utilities().inputContainerView(placeHolderText: "Nickname", textField: nicknameTextField)
        return view
    }()
    private let emailTextField: UITextField = {
       let tf = UITextField()
        return tf
    }()
    private let passwordTextField: UITextField = {
       let tf = UITextField()
        tf.isSecureTextEntry = true
        return tf
    }()
    private let fullnameTextField: UITextField = {
       let tf = UITextField()
        return tf
    }()
    private let nicknameTextField: UITextField = {
       let tf = UITextField()
        return tf
    }()
    
    private var signUpButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Email과 Password를 입력해주세요.", for: .normal)
        btn.layer.cornerRadius = 5
        btn.backgroundColor = UIColor.systemGroupedBackground
        btn.setTitleColor(UIColor.systemPurple, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.addTarget(self, action: #selector(tappedSignUp), for: .touchUpInside)
        return btn
    }()
    private var moveToLogIn: UIButton = {
        let btn = Utilities().button("계정이 있으신가요? ", "로그인하기")
        btn.addTarget(self, action: #selector(tappedLogInButton), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        fullnameTextField.delegate = self
        nicknameTextField.delegate = self
        
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
    @objc func tappedSignUp() {
        print("회원가입을 시도합니다.")
        createUserAccount()
    }
    
    @objc func tappedLogInButton() {
        print("로그인 화면으로 돌아갑니다.")
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - API
    func createUserAccount() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        guard let nickname = nicknameTextField.text?.lowercased() else { return }
        guard let profileImage = self.profileImage ?? UIImage(systemName: "person.circle.fill") else { return }
        
        let authCredentials = AuthCredentials(email: email, password: password, fullname: fullname, username: nickname, profileImage: profileImage)
        AuthenticationService.createUserAccount(withCredential: authCredentials) { error in
            if let error = error {
                print("계정 생성에 실패하였습니다.")
            }
            print("계정 생성에 성공하였습니다.")
            //navigationController?.popViewController(animated: true)
            self.delegate?.authenticationDidComplete()
            // 아주 놀랍게도, 계정을 만드는 것과 동시에, 로그인이 진행된다. 이후에 Auth.auth().currentUser값이 true가 된다.
        }
    }
    
    // MARK: - Helper
    func configureUI() {
        setGradientLayer()
        configureNavigationUI()
        
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
    
    func configureNavigationUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    func signUpButtonViewModel() {
        let viewModel = SignUpViewModel(profileImage: profileImage, email: emailTextField.text, password: passwordTextField.text,fullname: fullnameTextField.text, nickname: nicknameTextField.text, btn: signUpButton)
        signUpButton = viewModel.settingButton
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

extension SignUpController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        signUpButtonViewModel()
    }
}
