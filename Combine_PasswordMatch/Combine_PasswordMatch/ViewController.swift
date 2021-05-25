//
//  ViewController.swift
//  Combine_PasswordMatch
//
//  Created by YunHo on 2021/05/25.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var checkPassword: UITextField!
    @IBOutlet weak var btn: UIButton!
    
    var viewModel: ViewModel!
    
    private var cancel = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel = ViewModel()
        
        password.myTextPublisher
//            .print() -> 로그 찍기 가능
            .receive(on: DispatchQueue.main) // 메인스레드에서 동작
            .assign(to: \.passwordInput, on: viewModel) // 이벤트 받음 (구독)
            .store(in: &cancel) // 메모리 해제
        
        checkPassword.myTextPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.checkPasswordInput, on: viewModel)
            .store(in: &cancel)
        
        // 버튼이 ViewModel의 Publisher를 구독
        viewModel.isMatch
            .receive(on: RunLoop.main) // RunLoop: 다른스레드와 같이 작업 시 사용
            .assign(to: \.isValid, on: btn)
            .store(in: &cancel)
    }
}

extension UITextField {
    var myTextPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap{ $0.object as? UITextField } // UITextField 가져옴
            .map{ $0.text ?? "" } // String 가져옴
//            .print() -> 로그 찍기 가능
            .eraseToAnyPublisher() // AnyPublisher
    }
}

extension UIButton {
    var isValid: Bool {
        get{
            backgroundColor == .lightGray
        }
        set{
            backgroundColor = newValue ? .yellow : .lightGray
            isEnabled = newValue
            setTitleColor(newValue ? .blue : .white, for: .normal)
        }
    }
}
