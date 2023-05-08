//
//  LoginController.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/21.
//

import UIKit
protocol AuthenticationDelegate: class {
    func authenticationDidComplete()
}

class LoginController: UIViewController {
    // MARK: - Properties
    weak var delegate: AuthenticationDelegate?
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        return iv
    }()
    private lazy var emailView:UIView  = {
        let view = Utilities().inputContainerView(placeHolderText: "Email", textField: emailTextField)
        return view
    }()
    private lazy var passwordView: UIView = {
        let view = Utilities().inputContainerView(placeHolderText: "Password", textField: passwordTextField)
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
    private lazy var signInButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.setTitle("Email과 Password를 입력해주세요.", for: .normal)
        btn.backgroundColor = UIColor.systemGroupedBackground
        btn.setTitleColor(UIColor.systemPurple, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(tappedLogIn), for: .touchUpInside)
        btn.layer.cornerRadius = 5
        return btn
    }()
    private var stateLabel: UIButton = {
        let btn = Utilities().button("비밀번호를 잊으셨나요? ", "비밀번호 찾기")
        btn.addTarget(self, action: #selector(tappedSearchPassword), for: .touchUpInside)
        return btn
    }()
    private var moveToSignUpLabel: UIButton = {
        let btn = Utilities().button("계정이 없으신가요? ", "회원가입")
        btn.addTarget(self, action: #selector(tappedSignUp), for: .touchUpInside)
        return btn
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        configureUI()
        
    }
    // MARK: - Selectors
    @objc func tappedSearchPassword() {
        print("비밀번호 찾기를 누르셨습니다.")
    }
    @objc func tappedLogIn() {
        print("로그인을 시도합니다.")
            guard let email = emailTextField.text?.lowercased() else { return }
            guard let password = passwordTextField.text else { return }
            AuthenticationService.logInUser(email: email, password: password) { result, error in
                if let error = error {
                    print("로그인에 실패하였습니다.")
                    return
                }
                print("로그인에 성공했습니다.")
                self.delegate?.authenticationDidComplete()
                
            }
        
    }
    
    @objc func tappedSignUp() {
        print("회원가입 버튼을 누르셨습니다.")
        let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
    }
    // MARK: - Helper
    func configureUI() {
        setGradientLayer()
        configureNavigationUI()
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 80)
        
        let stack = UIStackView(arrangedSubviews: [emailView, passwordView, signInButton, stateLabel])
        stack.axis = .vertical
        stack.spacing = 12
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 20, paddingRight: 20)
        
        view.addSubview(moveToSignUpLabel)
        moveToSignUpLabel.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 12, paddingBottom: 40, paddingRight: 12)
    }
    
    func configureNavigationUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black // 이부분을 통해, 디바이스 가장 위 상태버튼들의 색상이 흰색으로 바뀐다.(네비게이션 바가 검은색이니, 대비되게 흰색으로 바뀌는 것)
    }
    
    func loginButtonViewModel() {
        var viewModel = LoginViewModel(email: emailTextField.text, password: passwordTextField.text, btn: signInButton)
        signInButton = viewModel.settingButton
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension LoginController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("실행됨")
        loginButtonViewModel()
    }
}
