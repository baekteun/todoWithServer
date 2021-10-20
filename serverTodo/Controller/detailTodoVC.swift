//
//  detailTodoVC.swift
//  serverTodo
//
//  Created by baegteun on 2021/10/20.
//

import Foundation
import UIKit
import Then
import SnapKit

protocol editDelegate: class{
    func editDidFinish()
}
class detailTodoVC: baseVC{
    weak var delegate: editDelegate?
    
    private let dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
    }
    
    private let titleTextField = UITextField().then {
        $0.placeholder = "title"
    }
    
    var model: todoModel?{
        didSet{
            addView()
            setLayout()
            bind()
        }
    }
    
    override func configureVC() {
        super.configureVC()
        
        
    }
    private func addView(){
        [dateLabel, titleTextField].forEach{view.addSubview($0)}
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(didTappedRewrite))
    }
    private func setLayout(){
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(bound.width*0.75)
        }
    }
    private func bind(){
        guard let model = model else {
            return
        }
        dateLabel.text = model.날짜
        
        titleTextField.text = model.할일
    }
    
    // MARK: - Actions
    @objc private func didTappedRewrite(){
        guard var model = model else {
            return
        }
        model.제목 = titleTextField.text!
        
        API.updateTodo(model)
        self.delegate?.editDidFinish()
    }
}
