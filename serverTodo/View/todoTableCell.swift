//
//  todoTableCell.swift
//  serverTodo
//
//  Created by baegteun on 2021/10/20.
//

import Foundation
import UIKit
import Then
import SnapKit

class todoTableCell: UITableViewCell{
    static let reuse = "todoTableCell"
    
    let titleLabel = UILabel()
    
    let dateLabel = UILabel()
    
    let todoLabel = UILabel()
    
    lazy var stack = UIStackView(arrangedSubviews: [titleLabel, dateLabel]).then {
        $0.axis = .vertical
        $0.spacing = 5
    }
    
    var model : todoModel?{
        didSet{
            configureCell()
            bind()
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCell(){
        [stack, todoLabel].forEach{addSubview($0)}
        
        stack.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(10)
        }
        todoLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(stack.snp.right).offset(20)
        }
    }
    func bind(){
        guard let model = model else {
            return
        }
        titleLabel.text = "[\(model._id)]\(model.제목)"
        
        dateLabel.text = model.날짜
        
        todoLabel.text = model.할일
    }
}
