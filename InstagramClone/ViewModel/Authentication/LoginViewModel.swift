//
//  LoginViewModel.swift
//  InstagramClone
//
//  Created by 모상현 on 2023/04/24.
//

import UIKit

struct LoginViewModel {
    var email: String
    var password: String
    
    var isStateButton: Bool {
        return email.contains("@") && password.count >= 8
    }
    
    var settingButton: UIButton
    
    init(email: String?, password: String?, btn: UIButton) {
        self.email = email ?? ""
        self.password = password ?? ""
        self.settingButton = btn
        configureButton()
    }
    
    mutating func configureButton() {
            if isStateButton {
                settingButton.backgroundColor = .systemPurple
                settingButton.isEnabled = true
                settingButton.setTitleColor(UIColor.white, for: .normal)
                settingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                settingButton.setTitle("Log In", for: .normal)
            } else {
                
                settingButton.backgroundColor = UIColor.systemGroupedBackground
                settingButton.isEnabled = false
                settingButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
                if email == "" && password == "" {
                    settingButton.setTitleColor(UIColor.systemPurple, for: .normal)
                    settingButton.setTitle("Email과 Password를 입력해주세요.", for: .normal)
                } else {
                    settingButton.setTitleColor(UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5), for: .normal)
                    settingButton.setTitle(email.contains("@") ? "비밀번호를 8자리 이상 입력해주세요." : "올바른 이메일 형식이 아닙니다.", for: .normal)
                }
                
            }
    }
}
