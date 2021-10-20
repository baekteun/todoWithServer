//
//  addTodoVC.swift
//  serverTodo
//
//  Created by baegteun on 2021/10/20.
//

import Foundation
import UIKit
import Then
import SnapKit
import Alamofire

protocol addTodoDelegate: class{
    func didFinishAdd()
}
class addTodoVC: baseVC{
    // MARK: - Properties
    weak var delegate: addTodoDelegate?
    
    private let titleTextField = UITextField().then {
        $0.placeholder = "할일"
        $0.font = .systemFont(ofSize: 32)
    }
    
    // 뭐야 내용이 없는데?
    
    private let dateFormatter = DateFormatter().then {
        $0.locale = Locale(identifier: "KO_KR")
        $0.dateFormat = "MM-dd"
    }
    
    private let completeBtn = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .blue.withAlphaComponent(0.7)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(didTappedCompleteBtn), for: .touchUpInside)
    }
    
    // MARK: - Helpers
    override func configureVC() {
        addView()
        setLayout()
        
        view.backgroundColor = .white
        
        
    }
    private func addView(){
        [titleTextField, completeBtn].forEach{view.addSubview($0)}
    }
    private func setLayout(){
        titleTextField.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.top.equalTo(view.snp.top).offset(20)
        }
        
        completeBtn.snp.makeConstraints {
            $0.width.equalTo(view.frame.width*0.75)
            $0.height.equalTo(70)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleTextField.snp.bottom).offset(view.frame.height*0.1)
        }
    }
    
    // MARK: - Actions
    @objc func didTappedCompleteBtn(){
        let todo = todoModel(할일: titleTextField.text!, 날짜: dateFormatter.string(from: Date()), 제목: titleTextField.text!)
        API.createTodo(todo, delegate: delegate!)
    }
}
