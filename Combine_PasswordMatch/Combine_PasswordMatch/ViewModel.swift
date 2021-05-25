//
//  ViewModel.swift
//  Combine_PasswordMatch
//
//  Created by YunHo on 2021/05/25.
//

import Foundation
import Combine

class ViewModel {
    
    @Published var passwordInput: String = "" {
        didSet {
            print("ViewModel - password : \(passwordInput)")
        }
    }
    
    @Published var checkPasswordInput: String = "" {
        didSet {
            print("ViewModel - checkPssword : \(checkPasswordInput)")
        }
    }
    
    // 값 일치 여부 확인
    lazy var isMatch: AnyPublisher<Bool, Never> =
        Publishers.CombineLatest($passwordInput, $checkPasswordInput)
        .map({ (password: String, checkPassword: String) in
            if password == "" || checkPassword == "" {
                return false
            }
            
            if password == checkPassword {
                return true
            }
            else {
                return false
            }
        })
        .eraseToAnyPublisher()
}
