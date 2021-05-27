//
//  ViewController.swift
//  Combine_Debounce
//
//  Created by YunHo on 2021/05/27.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController()
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.tintColor = .black
        search.searchBar.searchTextField.accessibilityIdentifier = "mySearchTextField"
        return search
    }()
    
    var cancel = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.searchController = searchController
        searchController.isActive = true
        
        searchController.searchBar
            .searchTextField.debouncePub
            .sink{ [weak self] (value) in // 이벤트를 받을 때 동작 (구독)
                print("recieveValue: \(value)")
                
                // self.label.text = value -> retain cycle이 발생할 수 있음
                self?.label.text = value // [weak self]: 약한참조, 이후 옵셔널 처리
                //또는 guard self = self {return} 처리
            }
            .store(in: &cancel)
    }


}

extension UISearchTextField {
    var debouncePub: AnyPublisher<String, Never>{
        NotificationCenter.default
            .publisher(for: UISearchTextField.textDidChangeNotification, object: self)
            // NotificationCenter에서 UISearchTextField 가져옴
            .compactMap{ $0.object as? UISearchTextField }
            .map{$0.text ?? ""} // String 가져오기
//            .print()
            // debounce: 무분별한 api호출을 방지하기 위해 사용
            .debounce(for: .milliseconds(1000), scheduler: RunLoop.main) // 1000: 1초
            // RunLoop -> Input resource에 주로 사용
            .filter{ $0.count > 0 } // 공백 이외에만 이벤트 전달
            .eraseToAnyPublisher()
        
    }
}
